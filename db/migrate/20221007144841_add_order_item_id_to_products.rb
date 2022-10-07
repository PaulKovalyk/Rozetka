class AddOrderItemIdToProducts < ActiveRecord::Migration[7.0]
  def change
    add_reference :products, :order_item, index: true, foreign_key: true
  end
end
