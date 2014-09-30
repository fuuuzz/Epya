class User < ActiveRecord::Base
  has_many :projects
  has_many :followers
  has_many :projects, :through => :follower
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
