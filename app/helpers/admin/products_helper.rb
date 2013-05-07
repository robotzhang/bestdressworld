module Admin::ProductsHelper
  def category_belongs_to_product?(category, product)
    return true if product.name.downcase.include?(category.name)
    return true if product.categories.map{|p| p.id}.include?(category.id)
    false
  end
end
