module Admin::CategoriesHelper
  def render_category_select()
    html="<select name='categories_select'>"
    Category.tree.each do |node, children|
      style = children.blank? ? '' : ' style="color: blue;"'
      html += "<option value='#{node.id}'#{style}>#{node.name}</option>"
      children.each do |child|
        child.each do |k, v|
          html += "<option value='#{k.id}'>#{k.name}</option>"
        end
        #render_category_select(child, html)
      end
    end

    (html+'</select>').html_safe
  end
end
