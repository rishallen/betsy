class DropCart < ActiveRecord::Migration
  def up
    drop_table :carts
    drop_table :cart_entries
  end
end
