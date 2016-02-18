require_dependency 'spree/shipping_calculator'

module Spree
  module Calculator::Shipping
    module Provident
      class International < Base
        def self.description
          "Provident International (includes Canada) (INTL)"
        end

        def carrier_code
          "INTL"
        end
      end
    end
  end
end
