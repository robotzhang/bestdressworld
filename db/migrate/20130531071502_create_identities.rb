class CreateIdentities < ActiveRecord::Migration
  def change
    create_table :identities do |t|
      t.references :user, :index => true
      t.string :uid
      t.string :provider
      t.string :name
      t.string :email
      t.string :image

      t.timestamps
    end
  end
end
