class AddNameColumnToUserTable < ActiveRecord::Migration
  def change
    add_column :users, :name, :string, :default => ""
  end
end
