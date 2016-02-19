# Defined for backward compatibility with 1-3-stable
# so that we can do the migrations.

module Spree
  class Calculator < ActiveRecord::Base
    module Provident
      class BestWayDomestic < Spree::Calculator::Shipping::Provident::BestWayDomestic
      end
    end
  end
end
