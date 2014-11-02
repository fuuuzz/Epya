class Comment < ActiveRecord::Base
  # Validation rules
  validates  :content,        presence: true
  # Set Assocs
  belongs_to :user
  belongs_to :project
end
