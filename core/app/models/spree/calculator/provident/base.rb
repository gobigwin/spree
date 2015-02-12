require 'digest/md5'
require_dependency 'spree/calculator'

module Spree
  class Calculator < ActiveRecord::Base
    module Provident
      class Base < Calculator
        def self.service_name
          self.description
        end

        def self.carrier_code
          ""
        end

        def compute(object)
          if object.is_a?(Array)
            order = object.first.order
          elsif object.is_a?(Shipment)
            order = object.order
          else
            order = object
          end
          addr = order.ship_address

          destination = Hash.new(:country => addr.country.iso,
                                 :state => (addr.state ? addr.state.abbr : addr.state_name),
                                 :city => addr.city,
                                 :zip => addr.zipcode[0..4])

          weight = calculate_weight(order)
          rate = calculate_rate(addr.country.iso, addr.zipcode[0..4], weight)
          #rate = Rails.cache.fetch(cache_key(order)) do
          #  weight = calculate_weight(order)
          #  calculate_rate(destination, weight)
          #end

          raise rate if rate.kind_of?(Spree::ShippingError)
          return nil unless rate
          return nil if rate.empty?

          rate = rate.to_f + (Spree::ActiveShipping::Config[:handling_fee].to_f || 0.0)

          return rate
        end

        protected
        def max_weight_for_country(country)
          0
        end

        private

        def calculate_weight(order)
          weight = 0.0
          multiplier = Spree::ActiveShipping::Config[:unit_multiplier]
          default_weight = Spree::ActiveShipping::Config[:default_weight]
          order.line_items.each do |line_item|
            item_weight = line_item.variant.weight.to_f
            item_weight = default_weight if item_weight <= 0
            item_weight *= multiplier

            quantity = line_item.quantity
            weight += (item_weight * quantity)
          end
          return weight
        end

        def calculate_rate(country, zip, weight)
          # Weight tables max out at 70 pounds. So if order is over 70 pounds we need to split the shipping calculations
          if weight > 70.0000
            rate = calculate_rate(country, zip, 70.0000).to_f + calculate_rate(country, zip, (weight - 70.0000)).to_f
            return rate.to_s
          end
          query = "SELECT price FROM spree_provident_shipping_schedule WHERE carrier_code = '#{carrier_code}' AND country = '#{country}' "
          if country == 'US'
            zip.gsub!(/[^0-9]/, '')
            zip.sub!(/^0+/, '')
            zip = Integer(zip)
            query << " AND zip_start <= #{zip} AND zip_end >= #{zip} "
          end
          query << " AND max_weight >= #{weight} ORDER BY max_weight ASC LIMIT 1"
          result = ActiveRecord::Base.connection.execute(query)
          if result && result.first
            rate = result.first['price']
          elsif country == 'US'
            query = "SELECT price FROM spree_provident_shipping_schedule WHERE carrier_code = '#{carrier_code}' AND country = '#{country}' "
            query << " AND zip_start IS NULL AND zip_end IS NULL "
            query << " AND max_weight >= #{weight} ORDER BY max_weight ASC LIMIT 1"
            result = ActiveRecord::Base.connection.execute(query)
            if result && result.first
              rate = result.first['price']
            else
              rate = nil
            end
          else
            rate = nil
          end
          unless rate
            error = Spree::ShippingError.new("#{I18n.t(:shipping_error)}: Your cart is too heavy for shipping.")
            return error
          end
          return rate
        end

        def cache_key(order)
          addr = order.ship_address
          line_items_hash = Digest::MD5.hexdigest(order.line_items.map {|li| li.variant_id.to_s + "_" + li.quantity.to_s }.join("|"))
          @cache_key = "#{carrier.name}-#{order.number}-#{addr.country.iso}-#{addr.state ? addr.state.abbr : addr.state_name}-#{addr.city}-#{addr.zipcode}-#{line_items_hash}-#{I18n.locale}".gsub(" ","")
        end
      end
    end
  end
end
