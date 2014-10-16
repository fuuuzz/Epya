class Project < ActiveRecord::Base
	belongs_to :user
	has_and_belongs_to_many :users
	has_many :project_tags
  	has_many :tags, :through => :project_tags
end
