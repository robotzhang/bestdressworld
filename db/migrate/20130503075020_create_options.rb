class CreateOptions < ActiveRecord::Migration
  def change
    create_table :options do |t|

      t.timestamps
    end
  end
end
