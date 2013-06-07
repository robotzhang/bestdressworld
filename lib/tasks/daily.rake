namespace :daily do
  # 自动打标签
  task :tags => :environment do

  end

  # 每日统计，更新数据到表中
  task :count => :environment do
    p Product.count
  end

  # 自动计算产品的order_rank
  task :order_rank => :en
end