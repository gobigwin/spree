require_dependency 'spree/calculator'

module Spree
  class Calculator < ActiveRecord::Base
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
