class User < ActiveRecord::Base
  has_many :projects
  
  has_many :followers
  validates_associated :followers
  
  has_many :projects, :through => :follower
  
  # Devise params
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end