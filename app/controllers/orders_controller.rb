# frozen_string_literal: true

class OrdersController < ApplicationController
  def new
    @order = Order.new
  end

  def create
    @order = Order.new(orders_params)

    if @order.save
      session[:cart] = nil
      @cart.update(product_ids: nil) unless current_user.nil?
      redirect_to root_path, notice: 'Order was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def orders_params
    params.permit(:first_name, :last_name, :phone, :address, :user_id, product_ids: [])
  end
end
