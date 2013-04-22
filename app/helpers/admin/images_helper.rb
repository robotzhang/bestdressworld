module Admin::ImagesHelper
  def image_width_height(image, max_height=50)
    height = image.height < max_height ? image.height : max_height
    width = image.width * height / image.height
    {:width => width, :height => height}
  end
end
