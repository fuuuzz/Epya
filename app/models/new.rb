class New < ActiveRecord::Base
  # Validation rules
  validates   :title, :content,        presence: true
  # Set Assocs
  belongs_to :user
  belongs_to :project
end
