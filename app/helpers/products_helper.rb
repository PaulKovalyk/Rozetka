module ProductsHelper
    def total_price_session
        price = Product.find(session[:cart]).collect{|product| product.price}.sum
    end

    def total_price_current_user
        price = Product.find(current_user.cart.product_ids).collect{|product| product.price}.sum
    end
end
  