require_dependency 'spree/calculator'

module Spree
  class Calculator < ActiveRecord::Base
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
