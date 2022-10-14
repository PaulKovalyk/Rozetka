require "rails_helper"

RSpec.describe 'OrdersController', type: :request do

  let!(:order) { create(:order) }
  let!(:user) {create(:user)}
  let!(:product) {create(:product)}
  let!(:valid_params) do
    {
      first_name: 'Books' , last_name: 'Books' , address: 'Books' ,phone: '5435345',product_ids: [product.id], user_id: user.id
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



  describe 'POST :create' do
    it 'creates success' do
      expect do
        post orders_url, params: valid_params
      end.to change(Order, :count).by(1)

      expect(response).to have_http_status(:found)
    end

    it 'creation failed' do
      expect do
        post orders_url, params: invalid_params
      end.to change(Order, :count).by(0)

      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  # describe 'PUT /update' do
  #   it 'update success' do
  #     put category_url(category), params: valid_params

  #     category.reload

  #     expect(category.name).to eq('Books')

  #   end

  #   it 'update failed' do
  #     put category_url(category), params: invalid_params

  #     category.reload

  #     expect(category.name).to eq(category.name)

  #   end
  # end
end
