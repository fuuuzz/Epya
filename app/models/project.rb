class Project < ActiveRecord::Base
  # Form validation rules
  validates   :name, :description,        presence: true
  validates   :collaborators,             presence: false
  validates_associated :followers
  
  # Set Assocs
	belongs_to :user
	has_and_belongs_to_many :users
	has_many :project_tags
  has_many :tags, :through => :project_tags
	has_many :comments
	has_many :news
	has_many :followers
	has_many :users, :through => :follower
	
	mount_uploader :photo, PhotoUploader

end
