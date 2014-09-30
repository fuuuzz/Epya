class AddFollowers < ActiveRecord::Migration
  def change
     drop_table   :follower
    create_table :followers do |t|
      t.belongs_to :project
      t.belongs_to :user
    end
  end
end
