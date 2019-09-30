class Book < ApplicationRecord
	validates :title, presence: true
	validates :body, presence: true
	belongs_to :user
	 validates :body, presence: true, uniqueness: true, length: {maximum: 199}
end
