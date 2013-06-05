#!/usr/bin/env ruby
require "./lib.rb"
Lib.connect(!ARGV[0].nil? ? ARGV[0] : "development")
require "../app/models/product"
require "../app/models/category"
require "../app/models/categories_product"
require "../app/models/option"
require "../app/models/options_product"

categories = Category.all
options = Option.all

Product.all.each do |product|
  # 自动分析和设置分类标签
  categories.each do |category|
    cate = category.name_en.gsub("dresses", "").gsub("dress", "").strip
    if product.name.downcase.include?(cate)
      info = " ( " + cate + " ) " + product.name
      if CategoriesProduct.where({category_id: category.id, product_id: product.id}).blank?
        result = CategoriesProduct.new(product_id: product.id, category_id: category.id).save
        p result.to_s + info
      else
        p "has" + info
      end
    end
  end

  # 自动分析和设置options标签
  options.each do |option|
    op = option.name_en.strip
    if product.name.downcase.include?(op)
      info = " ( " + op + " ) " + product.name
      if OptionsProduct.where({option_id: option.id, product_id: product.id}).blank?
        result = OptionsProduct.new(product_id: product.id, option_id: option.id).save
        p result.to_s + info
      else
        p "has" + info
      end
    end
  end
end
