class ProductsController < ApplicationController
  # skip_before_action :verify_authenticity_token
  #   protect_from_forgery with: :null_session
  before_action :set_product, only: %i[ show edit update destroy ]

  def index
    @products = Product.all
  end

  def show
    @product = Product.find(params[:id])
  end

  def new
    @product = Product.new
  end

  def edit
    @product = Product.find(params[:id])
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
    @product = Product.find(params[:id])
      if @product.update(product_params)
         redirect_to product_url(@product), notice: "Product was successfully updated."
      else
         render :edit
      end
  end

  def destroy
    @product = Product.find(params[:id])
    @product.destroy
      redirect_to products_url, notice: "Product was successfully destroyed."
  end

  private
    def set_product
      @product = Product.find(params[:id])
    end

    def product_params
      params.require(:product).permit(:title, :description, :price, product_ids: [])
    end
end
