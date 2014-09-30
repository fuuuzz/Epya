class AddIndexForFollower < ActiveRecord::Migration
  def change
    add_index :followers, [:user_id, :project_id], :name => 'follower_index'
  end
end
