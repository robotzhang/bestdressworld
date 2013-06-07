class AddRankingToProducts < ActiveRecord::Migration
  def change
    add_column :products, :ranking, :integer
    add_index :products, :ranking
  end
end
