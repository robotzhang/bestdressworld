class AddHitsToProducts < ActiveRecord::Migration
  def change
    add_column :products, :hits, :integer, :default => 0
  end
end
