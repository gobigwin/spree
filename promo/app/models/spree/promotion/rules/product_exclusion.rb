module Spree
  class Promotion
    module Rules
      class ProductExclusion < PromotionRule
        has_and_belongs_to_many :products, :class_name => '::Spree::Product', :join_table => 'spree_products_promotion_rules', :foreign_key => 'promotion_rule_id'
        
        def eligible_products
          products
        end

        def eligible?(order, options = {})
          return true if eligible_products.empty?
          return false if order.products.any? {|p| eligible_products.include?(p) }
        end
        
        def product_ids_string
          product_ids.join(',')
        end

        def product_ids_string=(s)
          self.product_ids = s.to_s.split(',').map(&:strip)
        end
      end
    end
  end
end