class Tag < ActiveRecord::Base
	has_many :user_tags
  	has_many :tags, :through => :user_tags
end
