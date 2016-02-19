# Defined for backward compatibility with 1-3-stable
# so that we can do the migrations.

module Spree
  class Calculator < ActiveRecord::Base
    module Provident
      class International < Spree::Calculator::Shipping::Provident::International
      end
    end
  end
end
