class AddUrlKeyToBrand < ActiveRecord::Migration
  def change
    add_column :brands, :url_key, :string
  end
end
