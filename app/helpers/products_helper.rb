# frozen_string_literal: true

module ProductsHelper
  def total_price_session
    price = Product.find(session[:cart]).collect(&:price).sum
  end

  def total_price_current_user
    price = Product.find(current_user.cart.product_ids).collect(&:price).sum
  end
end
