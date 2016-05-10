class ChangeDefaultValueForProductsCategory < ActiveRecord::Migration
  def change
    change_column :products, :category, :string, null: false, default: "Miscellaneous"
  end
end
