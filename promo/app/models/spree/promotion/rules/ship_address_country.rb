module Spree
  class Promotion
    module Rules
      class ShipAddressCountry < PromotionRule
        preference :country_id, :integer, :default => Spree::Config.default_country_id
        
        attr_accessible :preferred_country_id
        
        def eligible?(order, options = {})
          (order.shipping_address.try(:country_id) == preferred_country_id)
        end
      end
    end
  end
end