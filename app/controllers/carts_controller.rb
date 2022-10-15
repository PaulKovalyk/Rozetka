# frozen_string_literal: true

class CartsController < ApplicationController
  def add_product
    ids = @cart.product_ids << params[:id].to_i
    @cart.update(product_ids: ids)
    redirect_to root_path
  end

  def remove_product
    ids = @cart.product_ids
    ids.delete(params[:id].to_i)
    @cart.update(product_ids: ids)
    redirect_to root_path
  end

  def empty_cart
    @cart.update(product_ids: nil)
    redirect_to root_path
  end

  def show; end
end
