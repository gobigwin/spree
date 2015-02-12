class CreateProvidentShippingSchedule < ActiveRecord::Migration
  def change
    create_table :spree_provident_shipping_schedule do |t|
      t.string :carrier_code
      t.string :currency
      t.string :country
      t.integer :zip_start
      t.integer :zip_end
      t.integer :transit_days_min
      t.integer :transit_days_max
      t.decimal :max_weight, :precision => 8, :scale => 4
      t.decimal :price, :precision => 8, :scale => 2

      t.timestamps
    end

    add_index :spree_provident_shipping_schedule, :carrier_code
    add_index :spree_provident_shipping_schedule, :country
    add_index :spree_provident_shipping_schedule, :zip_start
    add_index :spree_provident_shipping_schedule, :zip_end
    add_index :spree_provident_shipping_schedule, :max_weight
  end
end
