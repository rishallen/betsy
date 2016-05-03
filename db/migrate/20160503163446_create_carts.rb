class CreateCarts < ActiveRecord::Migration
  def change
    create_table :carts do |t|
      t.integer, :session_id, null: false

      t.timestamps null: false
    end
  end
end
