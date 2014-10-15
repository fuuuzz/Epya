class CreateCollaborators < ActiveRecord::Migration
  def change
    create_table :collaborators do |t|
		t.belongs_to :project
      	t.belongs_to :user
    end
  end
end
