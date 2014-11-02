class User < ActiveRecord::Base
  has_many :projects
  has_many :user_tags
  has_many :tags, :through => :user_tags
  has_many :comments
  has_many :news
  has_many :followers
  has_many :projects, :through => :follower
  
  validates_associated :followers
  
  mount_uploader :avatar, AvatarUploader
  
  # Devise params
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         
  # Method for project's image upload
  # @param File file, the file submited
  # @return String name, the file name to save in database
  def self.imgupload(file)
    if file != nil
      name   = file.original_filename
      ext    = File.extname(name)
      random = rand(1..10000).to_s
      name   = name+'_'+random+ext
      while FileTest.exists?(Rails.root + 'public/uploads/images/avatars/' + name) do
        name = name+'_'+rand(1..10000).to_s+ext
      end
      File.open(Rails.root.join('public', 'uploads', 'images', 'avatars', name), 'wb') do |f|
        f.write(file.read)
      end
      return name
   else
     return
   end
 end
 
end
