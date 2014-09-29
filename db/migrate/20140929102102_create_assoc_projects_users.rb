class CreateAssocProjectsUsers < ActiveRecord::Migration
  def change
    create_table :follower do |t|
    	t.belongs_to :project
    	t.belongs_to :user
    end
  end
end
