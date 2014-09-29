class Project < ActiveRecord::Base
	belongs_to :user
	has_many :followers
	has_many :user, :through => :follower
end
