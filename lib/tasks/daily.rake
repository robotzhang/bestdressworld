namespace :daily do
  # 自动打标签
  task :tags => :environment do

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