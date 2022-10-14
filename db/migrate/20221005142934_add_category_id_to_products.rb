class AddCategoryIdToProducts < ActiveRecord::Migration[7.0]
  def change
    add_reference :products, :category, null: true
  end
end
