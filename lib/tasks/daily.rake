namespace :daily do
  # 自动打标签
  task :tags => :environment do
    categories = Category.all
    options = Option.all
    # 自动分析和设置分类标签
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
  end

  # 每日统计，更新数据到表中
  task :count => :environment do
    p Product.count
  end

  # 自动计算产品的ranking
  # 算法在Product model中维护
  task :ranking => :environment do
    Product.all.each do |product|
      product.update_column(:ranking, product.count_ranking) # 不更新时间戳
    end
  end
end