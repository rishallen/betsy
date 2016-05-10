class ChangeColumnParameterProductsStatus < ActiveRecord::Migration
  def change
    change_column :products, :status, :boolean, null: false, default: false
  end
end
