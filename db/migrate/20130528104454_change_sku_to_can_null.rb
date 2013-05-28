class ChangeSkuToCanNull < ActiveRecord::Migration
  def up
    change_column :products, :sku, :string, :null => true
  end

  def down
    change_column :products, :sku, :string, :null => false
  end
end
