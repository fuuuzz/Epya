class Project < ActiveRecord::Base
  # Form validation Project
  validates   :name, :description,        presence: true
  validates   :collaborators,             presence: false
  
	belongs_to :user
	has_and_belongs_to_many :users
	has_many :project_tags
  	has_many :tags, :through => :project_tags
	
	has_many :comments
	has_many :news
	has_many :followers
	#Add validations Follower
	validates_associated :followers
	
	has_many :users, :through => :follower
end
