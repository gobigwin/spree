require_dependency 'spree/shipping_calculator'

module Spree
  module Calculator::Shipping
    module Provident
      class SecondDayAir < Base
        def self.description
          "Provident Second Day Air domestic (2DA)"
        end

        def carrier_code
          "2DA"
        end
      end
    end
  end
end
