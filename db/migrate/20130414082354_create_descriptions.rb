class CreateDescriptions < ActiveRecord::Migration
  def change
    create_table :descriptions do |t|

      t.timestamps
    end
  end
end
