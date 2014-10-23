module Spree
  class Promotion
    module Rules
      class CurrentStore < PromotionRule
        preference :store_id, :integer

        attr_accessible :preferred_store_id

        def eligible?(order, options = {})
          order.store_id && (order.store_id == preferred_store_id)
        end
      end
    end
  end
end
