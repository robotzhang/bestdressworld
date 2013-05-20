# generate by command: rails g decorator Product
class ProductDecorator < Draper::Decorator
  delegate_all
  def name
    String.class_eval(%Q("#{object.name}"))
  end

  def seo_title
    return object.seo_title if !object.seo_title.blank?
    name.downcase+" - #{object.currency} #{object.currency_symbol} #{object.price.to_s}"
  end

  def seo_keywords
    return object.seo_keywords if !object.seo_keywords
    keywords = ""
    keywords += object.categories.map {|c| c.name}.join(' ') if !object.categories.blank?
    keywords += object.options.map {|o| o.name_en }.uniq.join(' ') if !object.options.blank?
    keywords
  end

  def seo_description(domain="bestdressworld.com")
    return object.seo_description if !object.seo_descriptions
    prefix = seo_keywords
    prefix += prefix+", "if !prefix.blank?
    "find the best #{prefix}#{name.downcase} in the world from #{domain}, buy from #{object.from_site}! "
  end
end

# for kaminari pagination
class ProductsDecorator < Draper::CollectionDecorator
  delegate :current_page, :total_pages, :limit_value
end
