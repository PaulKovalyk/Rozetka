# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ProductsController, type: :controller do
  let(:category) { create(:category) }
  let(:product) { create(:product, category_id: category.id) }
  let(:user) { create(:user) }

  before do
    sign_in(user)
  end

  describe 'GET /index' do
    it 'returns http success' do
      get :index

      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /new' do
    it 'returns http success' do
      get :new

      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /show/id' do
    it 'returns http success' do
      get :show, params: { id: product.id }

      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /edit' do
    it 'returns http success' do
      get :new, params: { id: product.id }

      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /create' do
    let(:valid_params) do
      {
        product: { title: 'Dell', description: ' Lorem ipsum dolor sit amet',
                   price: 40,
                   category_id: category.id }
      }
    end
    let(:invalid_params) { { product: { title: '', category_id: category.id } } }

    it 'creates success' do
      post :create, params: valid_params

      expect(response).to have_http_status(:found)
      expect(response).to redirect_to root_path
    end

    it 'creation failed' do
      post :create, params: invalid_params

      expect(response).to have_http_status(:unprocessable_entity)
      expect(response).to render_template :new
    end
  end

  describe 'GET /destroy' do
    it 'destroed success' do
      delete :destroy, params: { id: product.id }

      expect(response).to have_http_status(:found)
      expect(response).to redirect_to(root_path)
    end
  end

  describe 'GET /update' do
    let(:params) { { product: { title: 'ASUS', price: 400 }, id: product.id } }

    it 'update success' do
      put :update, params: params

      product.reload
      expect(product.title).to eq('ASUS')
      expect(product.price).to eq(400)
      expect(response).to redirect_to products_path
    end

    context 'when update is fail' do
      let(:params) { { product: { title: '', price: '300' }, id: product.id } }

      it 'update failed' do
        put :update, params: params

        product.reload

        expect(product.title).to eq(product.title)
        expect(product.price).to eq(product.price)
        expect(response).to render_template :edit
      end
    end
  end
end

# describe 'POST /add_to_cart' do
#   id = 1
#   it 'returns http success' do
#     post :add_to_cart, params:{id: id}
#     expect(session[:cart]).to match_array [id]
#   end
# end
