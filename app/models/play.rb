class Play < ApplicationRecord
	belongs_to :user
	belongs_to :category
	scope :filter_by_category, -> (category_id) { where category_id: category_id }
end
