class RenameCreateridToUserid < ActiveRecord::Migration
  def up
    rename_column :products, :creater_id, :user_id
  end

  def down
    rename_column :products, :user_id, :creater_id
  end
end
