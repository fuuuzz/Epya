class AddTableFollowers < ActiveRecord::Migration
  def change
  	create_table :followers do |f|
  		f.belongs_to :user
  		f.belongs_to :project
  	end
  	add_index :followers, [:user_id, :project_id], :unique => true, :name => 'follower_index'
  end
end
