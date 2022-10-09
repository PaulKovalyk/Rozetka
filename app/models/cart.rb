# frozen_string_literal: true

class Cart < ApplicationRecord
  belongs_to :user
  has_and_belongs_to_many :products

  # def self.create_cart_for_user(user)
  #     create(user_id: user.id)
  # end

  # def total_price
  #     @total_price = 0
  #     @cart.each do |product|
  #         @total_price += product.price
  #     end
  #     @total_price
  # end
end
