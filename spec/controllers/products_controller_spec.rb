# frozen_string_literal: true

require 'rails_helper'


RSpec.describe ProductsController, type: :controller do
  
  let(:category) { create(:category)}
  let(:product) { create(:product, category_id: category.id)}
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
  
  # describe 'POST /add_to_cart' do
  #   id = 1
  #   it 'returns http success' do
  #     post :add_to_cart, params:{id: id}
  #     expect(session[:cart]).to match_array [id]
  #   end
  # end
  
end
