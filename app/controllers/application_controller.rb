# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_cart_products

  def set_cart_products
    if user_signed_in?
      @cart = current_user.cart || current_user.create_cart
      session[:cart] = nil unless @cart.products.empty?
      @cart.product_ids = session[:cart] unless session[:cart].nil?
      @cart
    else
      session[:cart] ||= []
      @cart = Product.find(session[:cart])
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[email role first_name last_name])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[email role first_name last_name])
  end

  def after_sign_out_path_for(_resource_or_scope)
    new_user_session_path
  end
end
