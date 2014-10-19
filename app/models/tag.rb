class Tag < ActiveRecord::Base
	has_many :user_tags
	has_many :project_tags
  	has_many :tags, :through => :user_tag
  	has_many :tags, :through => :project_tag

  	# validation :name, presence => true
end
