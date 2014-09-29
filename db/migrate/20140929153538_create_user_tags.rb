class CreateUserTags < ActiveRecord::Migration
  def change
  	drop_table   :user_tags
    create_table :user_tags do |t|
      t.belongs_to :user
      t.belongs_to :tag
      t.timestamps
    end
  end
end
