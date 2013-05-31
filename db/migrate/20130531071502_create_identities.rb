class CreateIdentities < ActiveRecord::Migration
  def change
    create_table :identities do |t|
      t.string :uid
      t.string :provider
      t.references :user, :index => true
      t.string :image

      t.timestamps
    end
  end
end
