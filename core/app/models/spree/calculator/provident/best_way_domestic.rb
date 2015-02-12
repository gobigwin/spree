require_dependency 'spree/calculator'

module Spree
  class Calculator < ActiveRecord::Base
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
