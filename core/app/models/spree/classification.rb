module Spree
  class Classification < ActiveRecord::Base
    self.table_name = 'spree_products_taxons'
    belongs_to :product, :class_name => "Spree::Product"
    belongs_to :taxon, :class_name => "Spree::Taxon"

    validates_uniqueness_of :taxon_id, :scope => :product_id, :message => :already_linked
  end
end
