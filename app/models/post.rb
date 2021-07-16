class Post < ApplicationRecord
	include ImageUploader::Attachment(:image)

	validates :title, presence: true, length: {maximum: 100}
	validates :body, presence: true

	belongs_to :user
	has_many :comments
	has_many :likes

end
