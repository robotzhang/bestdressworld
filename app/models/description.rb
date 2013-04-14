class Description < ActiveRecord::Base
  # attr_accessible :title, :body
  belongs_to :product

  def get_from_amazon(item)
    features = item.get_elements('ItemAttributes/Feature')
    reviews = item.get_elements('EditorialReviews/EditorialReview')
    self.features = features.map { |e| e.get().strip }.join("\n") unless features.blank?
    self.content = reviews.map{|e| e.get('Content').strip}.join("\n\n") unless reviews.blank?
    self
  end
end
