require "rails_helper"
RSpec.describe '/categories', type: :request do

  let(:category) { create(:category) }
  let(:valid_params) do
    {
      category: { name: 'Books' }
    }
  end
  let(:invalid_params) do
    {
      category: { name: '' }
    }
  end

  describe 'GET /index' do
    it 'returns http success' do
      get category_url(category)

      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST /create' do
    it 'creates success' do
      expect do
        post categories_url, params: valid_params
      end.to change(Category, :count).by(1)

      expect(response).to have_http_status(:found)
    end

    it 'creation failed' do
      expect do
        post categories_url, params: invalid_params
      end.to change(Category, :count).by(0)

      expect(response).to have_http_status(:unprocessable_entity)
    end
  end





  describe 'GET /update' do
    it 'update success' do
      put category_url(category), params: valid_params

      category.reload

      expect(category.name).to eq('Books')

    end

  end
end
