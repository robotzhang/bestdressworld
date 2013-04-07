class CreateProductReviews < ActiveRecord::Migration
  def change
    create_table :product_reviews do |t|

      t.timestamps
    end
  end
end
