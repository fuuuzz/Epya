class User < ActiveRecord::Base
  has_many :projects
  has_many :user_tags
  has_many :tags, :through => :user_tags
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
