class OptionsProduct < ActiveRecord::Base
  # attr_accessible :title, :body
  validates_uniqueness_of :product_id, :scope => :option_id
end
