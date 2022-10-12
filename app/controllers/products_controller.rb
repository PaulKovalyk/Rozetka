# frozen_string_literal: true

class ProductsController < ApplicationController
  before_action :authenticate_user!, only: %i[create new]

  def add_to_cart
    id = params[:id].to_i
    session[:cart] << id unless session[:cart].include?(id)
    redirect_to root_path
  end

  def remove_from_cart
    id = params[:id].to_i
    session[:cart].delete(id)
    redirect_to root_path
  end

  def delete_session_cart
    session[:cart] = nil
    redirect_to root_path, notice: 'Cart was successfully deleted.'
  end

  def index
    @cart = set_cart_products
    @products = collection
  end

  def show
    @product = resource
  end

  def new
    @product = Product.new
  end

  def edit
    @product = resource
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to root_path, notice: 'Product was successfully created.'
    else
      redirect_to root_path
    end
  end

  def update
    @product = resource
    if @product.update(product_params)
      redirect_to product_url(@product), notice: 'Product was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @product = resource
    @product.destroy
    redirect_to products_url, notice: 'Product was successfully destroyed.'
  end

  private

  def collection
    Product.all
  end

  def resource
    collection.find(params[:id])
  end

  def set_cart_products
    if user_signed_in?
      @cart = current_user.cart || current_user.create_cart
      session[:cart] = nil unless @cart.products.empty?
      @cart.product_ids = session[:cart] unless session[:cart].nil?
      @cart.products
    else
      session[:cart] ||= []
      Product.find(session[:cart])
    end
  end

  def product_params
    params.require(:product).permit(:title, :description, :price, :category_id, :status, :order_id)
  end
end
