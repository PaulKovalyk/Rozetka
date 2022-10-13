require "rails_helper"
RSpec.describe '/categories', type: :request do
 # let(:category) { create(:category) }
  describe 'POST /create' do
    let(:valid_params) do
      {
        category: { name: 'Books' }
      }
    end
    it 'creates a new Category' do
      expect do
        post categories_url, params: valid_params
      end.to change(Category, :count).by(1)
    end
  end
end
