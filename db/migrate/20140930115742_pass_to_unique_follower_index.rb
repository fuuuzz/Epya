class PassToUniqueFollowerIndex < ActiveRecord::Migration
  def change
    add_index :followers, [:user_id, :project_id], :unique => true, :name => 'follower_index'
  end
end
