class User < ApplicationRecord
  include ImageUploader::Attachment(:image)
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  has_many :posts
  has_many :comments
  has_many :likes

  has_many :follower_follows, foreign_key: :following_id, class_name: "Follow"
  has_many :followers, through: :follower_follows, source: :follower

  has_many :following_follows, foreign_key: :follower_id, class_name: "Follow"
  has_many :followings, through: :following_follows, source: :following
	
  validates :email, presence: true, uniqueness: true
  validates :name, presence: true
  validates :username, presence: true
end
