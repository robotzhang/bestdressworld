class Description < ActiveRecord::Base
  # attr_accessible :title, :body
  belongs_to :product

  def get_from_amazon(item)
    self.summary = item.get_elements('ItemAttributes/Feature').map { |e| e.get().strip }.join("\n")
    self.content = self.summary + "\n\n" + item.get_elements('EditorialReviews/EditorialReview').map{|e| e.get('Content').strip}.join("\n\n")
    self
  end
end
