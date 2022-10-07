class ProductsController < ApplicationController
  include SessionCart

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

  def index
    session[:cart] ||= []
    @cart = Product.find(session[:cart])
    @total_price = 0
    @cart.each do |product|
      @total_price += product.price
    end
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
      redirect_to product_url(@product), notice: "Product was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @product = resource
    if @product.update(product_params)
      redirect_to product_url(@product), notice: "Product was successfully updated."
    else
      render :edit
    end
  end

  def destroy
    @product = resource
    @product.destroy
    redirect_to products_url, notice: "Product was successfully destroyed."
  end

  private

  def collection
    Product.all
  end

  def resource
    collection.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:title, :description, :price, :category_id, :status)
  end
end
