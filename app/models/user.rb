class User < ActiveRecord::Base
  has_many :projects
  has_many :user_tags
  has_many :tags, :through => :user_tags
  has_many :comments
  has_many :news
  has_many :followers
  has_many :projects, :through => :follower
  
  validates_associated :followers
  
  mount_uploader :avatar, AvatarUploader
  
  # Devise params
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
 
end
