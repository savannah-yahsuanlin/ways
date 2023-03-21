class Play < ApplicationRecord
	belongs_to :user
	belongs_to :category
	has_many :reviews
	has_one_attached :image
	scope :filter_by_category, -> (category_id) { where category_id: category_id }
end
