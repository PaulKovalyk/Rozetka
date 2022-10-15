# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'OrdersController', type: :request do
  let!(:order) { create(:order) }
  let!(:user) { create(:user) }
  let!(:product) { create(:product) }
  let!(:valid_params) do
    {
      first_name: 'Books', last_name: 'Books', address: 'Books', phone: '5435345', product_ids: [product.id], user_id: user.id
    }
  end
  let!(:invalid_params) do
    {
      order: { first_name: '' }
    }
  end

  describe 'GET :new' do
    it 'returns http success' do
      get new_order_path

      expect(response).to have_http_status(:success)
    end
  end

  # describe 'GET :index' do
  #   it 'renders a successful response' do
  #     get orders_path

  #     expect(response).to be_successful
  #   end
  # end

  # describe 'GET :show' do
  #   it 'renders a successful response' do
  #     get order_path(order)

  #     expect(response).to be_successful
  #     expect(response).to render_template(:show)
  #     expect(response.body).to include(order.first_name)
  #   end
  # end

  describe 'POST :create' do
    it 'creates success' do
      expect do
        post orders_url, params: valid_params
      end.to change(Order, :count).by(1)

      expect(response).to redirect_to(root_path)
    end

    it 'creation failed' do
      expect do
        post orders_url, params: invalid_params
      end.not_to change(Order, :count)

      expect(response).to render_template(:new)
    end
  end

  # describe 'DELETE :destroy' do
  #   it 'destroys the requested order' do
  #     expect do
  #       delete order_url(order)
  #     end.to change(Order, :count).by(-1)
  #   end

  #   it 'redirects to the orders list' do
  #     delete order_url(order)
  #     expect(response).to redirect_to(orders_url)
  #     expect(flash[:notice]).to eq('Order was successfully destroyed.')
  #   end
  # end
end
