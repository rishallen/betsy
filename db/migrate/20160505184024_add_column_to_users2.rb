class AddColumnToUsers2 < ActiveRecord::Migration
  def change
    add_column :users, :password_digest, :string, null: false
    remove_column :users, :password, :string
  end
end
