# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'CategoriesController', type: :request do
  let!(:category) { create(:category) }
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

  describe 'GET :index' do
    it 'returns http success' do
      get categories_path

      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET :new' do
    it 'returns http success' do
      get new_category_path

      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET :edit' do
    it 'returns http success' do
      get edit_category_path(category)

      expect(response).to have_http_status(:success)
    end
  end

  describe 'DELETE :destroy' do
    it 'destroys the requested category' do
      expect do
        delete category_url(category)
      end.to change(Category, :count).by(-1)
    end

    it 'redirects to the category list' do
      delete category_url(category)
      expect(response).to redirect_to(categories_url)
      expect(flash[:notice]).to eq('Category was successfully deleted.')
    end
  end

  describe 'POST :create' do
    it 'creates success' do
      expect do
        post categories_url, params: valid_params
      end.to change(Category, :count).by(1)

      expect(response).to redirect_to categories_path
    end

    it 'creation failed' do
      expect do
        post categories_url, params: invalid_params
      end.not_to change(Category, :count)

      expect(response).to render_template(:new)
    end
  end

  describe 'PUT :update' do
    it 'update success' do
      put category_url(category), params: valid_params

      category.reload

      expect(category.name).to eq('Books')
      expect(response).to redirect_to categories_path
    end

    it 'update failed' do
      put category_url(category), params: invalid_params

      category.reload

      expect(category.name).to eq(category.name)
      expect(response).to render_template(:edit)
    end
  end
end
