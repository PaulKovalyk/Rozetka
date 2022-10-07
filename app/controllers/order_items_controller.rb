class OrderItemsController < ApplicationController
    
    def new
        @order_item = OrderItem.new
    end
    
    def create
        @order_item = OrderItem.new(order_items_params)
        if @order_item.save
            redirect_to root_path, notice: "Order was successfully created."
        else
            render :new, status: :unprocessable_entity
        end
    end

    private

    def order_items_params
        params.require(:order_item).permit(:firstname, :lastname, :phone)
    end
end