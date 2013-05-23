#coding=utf-8
class CreateBrands < ActiveRecord::Migration
  def change
    create_table :brands do |t|
      t.string :name, :null => false # 品牌名称
      t.integer :user_id
      t.string :website #网站url
      t.string :introduce # 品牌简介
      t.string :logo # 品牌logo

      t.timestamps
    end
  end
end
