class CreateNews < ActiveRecord::Migration
  def change
    create_table :news do |t|
      t.belongs_to :user
      t.belongs_to :project
      t.text :content
      t.string :title
      t.timestamps
    end
  end
end
