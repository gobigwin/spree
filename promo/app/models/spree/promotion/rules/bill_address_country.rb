module Spree
  class Promotion
    module Rules
      class BillAddressCountry < PromotionRule
        preference :country_id, :integer, :default => Spree::Config.default_country_id
        
        attr_accessible :preferred_country_id
        
        def eligible?(order, options = {})
          (order.billing_address.try(:country_id) == preferred_country_id)
        end
      end
    end
  end
end