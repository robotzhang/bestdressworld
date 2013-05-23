class AddColumsToBrand < ActiveRecord::Migration
  def change
    change_table :brands do |t|
      t.string :slogan # 一句话口号
      t.string :country # 品牌所属国家
      t.integer :year # 创建年份
      t.string :good_at # 擅长分类
      change_column :brands, :introduce, :text
    end
  end
end
