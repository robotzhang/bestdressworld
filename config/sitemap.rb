# Set the host name for URL creation
SitemapGenerator::Sitemap.default_host = "http://www.bestdressworld.com"
SitemapGenerator::Sitemap.create_index = true
SitemapGenerator::Sitemap.create do
  # Put links creation logic here.
  #
  # The root path '/' and sitemap index file are added automatically for you.
  # Links are added to the Sitemap in the order they are specified.
  #
  # Usage: add(path, options={})
  #        (default options are used if you don't specify)
  #
  # Defaults: :priority => 0.5, :changefreq => 'weekly',
  #           :lastmod => Time.now, :host => default_host
  add root_path, :changefreq => 'daily'
  add products_path, :changefreq => 'daily'
  add brands_path, :changefreq => 'daily'
  Product.find_each do |product|
    add product_path(product.seo_url), :lastmod => product.updated_at
  end
  Brand.find_each do |brand|
    add brand_path(brand.url_key.blank? ? brand.id : brand.url_key), :lastmod => brand.created_at
  end
  #
  # Examples:
  #
  # Add '/articles'
  #
  #   add articles_path, :priority => 0.7, :changefreq => 'daily'
  #
  # Add all articles:
  #
  #   Article.find_each do |article|
  #     add article_path(article), :lastmod => article.updated_at
  #   end
end
