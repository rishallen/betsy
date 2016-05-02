class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.integer :item_id
      t.integer :user_id 
      t.string :status
      t.string :mailing_address
      t.integer :cc_digits
      t.date :expiration

      t.timestamps null: false
    end
  end
end
