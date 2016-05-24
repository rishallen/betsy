class AddColumnstoUserAndProducts < ActiveRecord::Migration
  def change
    add_column :users, :country, :string, null: false
    add_column :users, :state, :string, null: false
    add_column :users, :city, :string, null: false
    add_column :users, :zip, :integer, null: false
    add_column :products, :weight, :integer, null: false

  end
end
