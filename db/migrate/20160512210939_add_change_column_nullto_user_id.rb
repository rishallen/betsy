class AddChangeColumnNulltoUserId < ActiveRecord::Migration
  def change
    change_column_null :reviews, :user_id, true
  end
end
