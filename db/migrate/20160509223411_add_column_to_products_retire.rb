class AddColumnToProductsRetire < ActiveRecord::Migration
  def change
    add_column :products, :status, :boolean
  end
end
