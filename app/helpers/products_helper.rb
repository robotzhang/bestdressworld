module ProductsHelper
  def image_height_width(image, max_width=225)
    width = image.width < max_width ? image.width : max_width
    height = image.height * width / image.width
    {:width => width, :height => height}
  end

  def products_seo_title
    title = "all best dress of the world"
    title += " of page " + params[:page] if !params[:page].blank?
    title
  end

  def products_seo_description
    "find the best dress of the world from #{request.domain}, buy from amazon!"
  end
end
