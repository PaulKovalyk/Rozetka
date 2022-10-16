# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'ProductsController', type: :request do
  let!(:category) { create(:category) }
  let!(:product) { create(:product, category_id: category.id) }
  let!(:user) { create(:user, email: 'hello@com') }
  let!(:cart) { create(:cart, user_id: user.id, product_ids: []) }
  let!(:product1) { create(:product, category_id: category.id) }
  let(:invalid_attributes) do
    {
      product: {
        title: '1',
        price: 'cc',
        description: '  '
      }
    }
  end
  let(:new_attributes) do
    {
      product: { title: 'Kettle',
                 category_id: category.id,
                 price: 12_334,
                 description: 'blaaaa2' }
    }
  end

  describe 'GET :index' do
    context 'when user is authorized' do
      include_context 'authorize regular user'
      it 'renders a successful response' do
        get products_path

        expect(response).to be_successful
      end
    end
  end

  describe 'GET :show' do
    it 'renders a successful response' do
      get product_path(product)

      expect(response).to be_successful
      expect(response).to render_template(:show)
      expect(response.body).to include(product.title)
    end
  end

  describe 'GET :new' do
    it 'renders a successful response' do
      get new_product_path

      expect(response).to be_successful
    end
  end

  describe 'GET :edit' do
    it 'render a successful response' do
      get edit_product_path(product)

      expect(response).to be_successful
    end
  end

  describe 'POST :create' do
    let(:valid_attributes) do
      {
        product: {
          title: 'Phone',
          category_id: category,
          price: 1234,
          description: 'blaaaa'
        }
      }
    end

    context 'with valid parameters' do
      it 'is successfull' do
        expect do
          post products_url, params: valid_attributes
        end.to change(Product, :count).by(1)

        expect(response).to redirect_to(root_path)
      end
    end

    context 'with invalid parameters' do
      it 'is not successfull' do
        expect do
          post products_url, params: invalid_attributes
        end.not_to change(Product, :count)
        expect(response).to render_template(:new)
      end
    end
  end

  describe 'PUT :update' do
    context 'with valid parameters' do
      it 'be successful' do
        put product_url(product), params: new_attributes
        product.reload

        expect(product.title).to eq('Kettle')
        expect(response).to redirect_to(products_path)
        expect(flash[:notice]).to eq('Product was successfully updated.')
      end
    end

    context 'with invalid parameters' do
      it "renders a successful response (i.e. to display the 'edit' template)" do
        expect do
          patch product_url(product), params: invalid_attributes
        end.not_to change(product, :title)

        expect(response).to be_unprocessable
        expect(response).to render_template(:edit)
      end
    end
  end

  describe 'DELETE :destroy' do
    context 'when user is authorized' do
      before { sign_in user }

      it 'redirects to the product list' do
        delete product_url(product1)

        expect(response).to redirect_to(root_path)
        expect(flash[:notice]).to eq('Product was successfully destroyed.')
      end
    end

    context 'when user is authorized' do
      before { sign_in user }

      it 'redirects when product cant be deleted' do
        post add_product_path(product)

        cart.reload
        delete product_url(product)

        product.reload
        expect(response).to redirect_to(root_path)
        expect(flash[:notice]).to eq('The product cannot be removed, it is in the shopping cart.')
      end
    end
  end

  describe 'DELETE :destroy_for_session' do
    context 'when user is not authorized' do
      it 'redirects to the product list' do
        delete destroy_for_session_path(product1)

        expect(response).to redirect_to(root_path)
        expect(flash[:notice]).to eq('Product was successfully destroyed.')
      end
    end

    context 'when user is not authorized' do
      it 'redirects when product cant be deleted' do
        post add_to_cart_path(product)

        cart.reload
        delete destroy_for_session_path(product)

        product.reload
        expect(response).to redirect_to(root_path)
        expect(flash[:notice]).to eq('The product cannot be removed, it is in the shopping cart.')
      end
    end
  end

  describe 'POST :add_to_cart' do
    it 'add product to session cart' do
      post add_to_cart_path(product)

      expect(session[:cart]).to match_array(product.id)
      expect(response).to redirect_to root_path
    end
  end

  describe 'DELETE :remove_from_cart' do
    it 'delete product from session cart' do
      post add_to_cart_path(product)
      post add_to_cart_path(product1)
      delete remove_from_cart_path(product)

      expect(session[:cart]).not_to match_array(product.id)
      expect(session[:cart]).to match_array(product1.id)
      expect(response).to redirect_to root_path
    end
  end

  describe 'GET :delete_session_cart' do
    it 'destroy all products from session cart' do
      get delete_session_cart_path

      expect(session[:cart]).to be_nil
      expect(response).to redirect_to root_path
    end
  end
end
