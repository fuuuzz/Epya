class Project < ActiveRecord::Base
	belongs_to :user
	has_many :followers
	has_many :users, :through => :follower
end
