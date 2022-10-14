require 'rails_helper'

RSpec.describe 'ProductsController', type: :request do
  let!(:category) { create(:category) }
  let!(:product) { create(:product, category_id: category.id )}


  let(:invalid_attributes) do {
    product: {
      title: '1',
      price: 'cc',
      description: '  '
      }
    }
  end
  let(:new_attributes) do {
    product: {title: 'Kettle',
    category_id: category.id,
    price: 12334,
    description: 'blaaaa2'}
    }
  end

  describe 'GET :index' do
    it 'renders a successful response' do
      get products_path

      expect(response).to be_successful
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

  describe 'GET /edit' do
    it 'render a successful response' do
      get edit_product_path(product)
      expect(response).to be_successful
    end
  end

  describe 'POST :create' do
    let(:valid_attributes) do {
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
        end.to change(Product, :count).by(0)
        expect(response).to render_template(:new)
      end
    end
   end

  describe 'PATCH :update' do
    context 'with valid parameters' do
      it 'be successful' do
        put product_url(product), params: new_attributes
        product.reload
        expect(product.title).to eq('Kettle')
        # expect(response).to redirect_to(products_path)
        # expect(flash[:notice]).to eq('Product was successfully updated.')
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
    it 'destroys the requested category' do
      expect do
        delete product_url(product)
      end.to change(Product, :count).by(-1)
    end

    it 'redirects to the category list' do
      delete product_url(product)
      expect(response).to redirect_to(products_url)
      expect(flash[:notice]).to eq('Product was successfully destroyed.')
    end
  end

  describe 'POST :add_to_cart' do
    let(:new_attributes) do {
      product: {id: 1}
      }
    end
  it 'returns http success' do
    post :products_add_to_cart, params: product
    expect(session[:cart]).to match_array [id]
  end
end


end
