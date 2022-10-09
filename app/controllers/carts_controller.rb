# frozen_string_literal: true

class CartsController < ApplicationController
  def new
    @cart = Cart.new
  end

  def show; end

  def create
    @cart = Cart.create(cart_params)
  end

  private

  def cart_params
    params[:cart]
  end
end
