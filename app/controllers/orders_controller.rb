# frozen_string_literal: true

class OrdersController < ApplicationController
  def new
    @cart = Product.find(session[:cart])
    @order = Order.new
  end

  def create
    @order = Order.new(orders_params)
    if @order.save
      session[:cart] = nil
      redirect_to root_path, notice: 'Order was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def orders_params
    params.permit(:firstname, :lastname, :phone, product_ids: [])
  end
end
