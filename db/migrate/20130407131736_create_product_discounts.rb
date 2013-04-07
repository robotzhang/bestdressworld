class CreateProductDiscounts < ActiveRecord::Migration
  def change
    create_table :product_discounts do |t|

      t.timestamps
    end
  end
end
