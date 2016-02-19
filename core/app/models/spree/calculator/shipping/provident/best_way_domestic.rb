require_dependency 'spree/shipping_calculator'

module Spree
  module Calculator::Shipping
    module Provident
      class BestWayDomestic < Base
        def self.description
          "Provident Best Way Domestic (BWD)"
        end

        def carrier_code
          "BWD"
        end
      end
    end
  end
end
