class AddRankingToProducts < ActiveRecord::Migration
  def change
    add_column :products, :ranking, :integer, :default => 0
    add_index :products, :ranking
  end
end
