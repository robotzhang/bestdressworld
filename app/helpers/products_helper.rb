module ProductsHelper
  def image_height_width(image, max_width=225)
    width = image.width < max_width ? image.width : max_width
    height = image.height * width / image.width
    {:width => width, :height => height}
  end
end
