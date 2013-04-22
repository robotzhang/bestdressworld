module ProductsHelper
  def render_image(image, max_width=225)
    width = image.width < max_width ? image.width : max_width
    height = image.height * width / image.width

    "<img style='width:#{width};height:#{height};' src='#{image.url}'/>".html_safe
  end
end
