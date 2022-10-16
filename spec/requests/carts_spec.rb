# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'CartsController', type: :request do
  let!(:user) { create(:user, email: 'hello@com') }
  let!(:cart) { create(:cart, user_id: user.id, product_ids: []) }
  let!(:product1) { create(:product) }
  let!(:product2) { create(:product) }

  describe 'POST :add_product' do
    context 'when user is authorized' do
      before { sign_in user }

      it 'add product to user cart' do
        post add_product_path(product1)

        cart.reload

        expect(cart.product_ids).to match_array(product1.id)
        expect(response).to redirect_to root_path
      end
    end
  end

  describe 'POST :remove_product' do
    context 'when user is authorized' do
      before { sign_in user }

      it 'remove product from user cart' do
        post add_product_path(product1)
        post remove_product_path(product1)

        cart.reload

        expect(cart.product_ids).not_to match_array(product1.id)
        expect(response).to redirect_to root_path
      end
    end
  end

  describe 'GET :empty cart' do
    context 'when user is authorized' do
      before { sign_in user }

      it 'will empty users cart' do
        post add_product_path(product1)
        post add_product_path(product2)
        get empty_cart_path

        cart.reload

        expect(cart.product_ids).to eq([])
        expect(response).to redirect_to root_path
      end
    end
  end
end
