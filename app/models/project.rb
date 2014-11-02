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
	
	# Method for project's image upload
	# @param File file, the file submited
	# @return String name, the file name to save in database
	def self.imgupload(file)
    name = file.original_filename
    File.open(Rails.root.join('public', 'uploads', 'images', 'projects', file.original_filename), 'wb') do |f|
      f.write(file.read)
    end
    return name
  end
end
