# frozen_string_literal: true

class ProductsController < ApplicationController
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
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @product = resource
    if @product.update(product_params)
      redirect_to products_url, notice: 'Product was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @product = resource
    if Cart.all.exclude?(product_ids: @product.id)
      @product.destroy
      flash[:notice] = 'Product was successfully destroyed.'
      redirect_to root_path
    else
      flash[:notice] = 'The product cannot be removed, it is in the shopping cart.'
      redirect_to root_path
    end
  end

  def destroy_for_session
    @product = resource
    if session[:cart].exclude?(@product.id)
      @product.destroy
      flash[:notice] = 'Product was successfully destroyed.'
      redirect_to root_path
    else
      flash[:notice] = 'The product cannot be removed, it is in the shopping cart.'
      redirect_to root_path
    end
  end

  private

  def collection
    Product.all
  end

  def resource
    collection.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:title, :description, :price, :category_id, :status, :order_id, :cart_id)
  end
end
