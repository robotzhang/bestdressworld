class MoveUserDataToIdentity < ActiveRecord::Migration
  def up
    User.all.each do |user|
      Identity.new(:user_id => user.id, :uid => user.sns_uid, :provider => user.sns_provider).save() if user.sns_uid && user.sns_provider
    end
  end

  def down
    Identity.delete_all
  end
end
