module Admin::OptionsHelper
  def option_belongs_to_product?(option, product)
    return true if product.name.downcase.include?(option.name_en)
    return true if product.options.map{|p| p.id}.include?(option.id)
    false
  end
end
