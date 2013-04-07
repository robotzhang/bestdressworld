class CreateProductDescriptions < ActiveRecord::Migration
  def change
    create_table :product_descriptions do |t|

      t.timestamps
    end
  end
end
