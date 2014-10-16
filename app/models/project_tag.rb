class ProjectTag < ActiveRecord::Base
	has_many :project
	belongs_to :tag
end
