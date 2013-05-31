class MoveUserDataToIdentity < ActiveRecord::Migration
  def up
    User.all.each do |user|
      Identity.new(:user_id => user.id, :uid => user.sns_uid, :provider => user.sns_provider).save() if user.sns_uid && user.sns_provider
    end
    remove_column :users, :sns_provider
    remove_column :users, :sns_uid
    add_column :users, :nickname, :string
  end

  def down
    Identity.delete_all
    add_column :users, :sns_provider, :string
    add_column :users, :sns_uid, :string
    remove_column :users, :nickname
  end
end
