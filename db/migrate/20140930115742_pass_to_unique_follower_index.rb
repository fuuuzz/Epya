class PassToUniqueFollowerIndex < ActiveRecord::Migration
  def change
    remove_index :followers, :name => 'follower_index'
    add_index :followers, [:user_id, :project_id], :unique => true, :name => 'follower_index'
  end
end
