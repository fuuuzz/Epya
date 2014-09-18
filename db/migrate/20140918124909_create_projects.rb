class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :name
      t.text :description
      t.string :photo
      t.string :tags
      t.string :author
      t.string :collaborators
      t.string :followers

      t.timestamps
    end
  end
end
