class CreateOptionsProducts < ActiveRecord::Migration
  def change
    create_table :options_products do |t|

      t.timestamps
    end
  end
end
