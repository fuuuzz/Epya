class AddFollowers < ActiveRecord::Migration
  def change
    create_table :followers do |t|
      t.belongs_to :project
      t.belongs_to :user
    end
  end
end
