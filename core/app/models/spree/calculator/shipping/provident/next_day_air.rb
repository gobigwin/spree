require_dependency 'spree/shipping_calculator'

module Spree
  module Calculator::Shipping
    module Provident
      class NextDayAir < Base
        def self.description
          "Provident Next Day Air domestic (1DA)"
        end

        def carrier_code
          "1DA"
        end
      end
    end
  end
end
