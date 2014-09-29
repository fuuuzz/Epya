class User < ActiveRecord::Base
  has_many :projects, dependent: :destroy
  has_and_belongs_to_many :projects
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
