class Post < ApplicationRecord
	include ImageUploader::Attachment(:image)

	validates :title, presence: true, length: {maximum: 100}
	validates :body, presence: true

	belongs_to :user
	has_many :comments
	has_many :likes

	# like the post
	def like(user)
	   likes << Like.new(user: user)
	end

	# unlike the post
	def unlike(user)
	   likes.where(user_id: user.id).first.destroy
	end
end
