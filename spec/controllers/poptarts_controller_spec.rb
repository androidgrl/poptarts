require 'rails_helper'

describe PoptartsController do
  #name has to match controller name
  context '#index' do
    it 'returns all the poptarts' do
      Poptart.create(flavor: 'strawberry', sprinkles: 'red')

      get :index, format: :json

      expect(response).to have_http_status(:ok)
      poptarts = JSON.parse(response.body)
      expect(poptarts['poptarts'].count).to eq(1)

      poptart = poptarts['poptarts'].last
      expect(poptart['flavor']).to eq('strawberry')
      expect(poptart['sprinkles']).to eq('red')
    end
  end

  context '#show' do
    it 'returns one poptart' do
      poptart = Poptart.create(flavor: 'smore', sprinkles: 'none')

      get :show, id: poptart.id, format: :json

      expect(response).to have_http_status(:ok)
      poptart_response = JSON.parse(response.body)

      expect(poptart_response['poptart']['flavor']).to eq('smore')
      expect(poptart_response['poptart']['sprinkles']).to eq('none')
    end

    it 'returns spooky poptarts on halloween' do
      poptart = Poptart.create(flavor: 'strawberry', sprinkles: 'rainbow')

      #/poptarts/1?promotion=halloween
      get :show, id: poptart.id, format: :json, promotion: 'halloween'

      poptart_response = JSON.parse(response.body)
      expect(poptart_response['flavor']).to eq('Spooky strawberry')
      expect(poptart_response['sprinkles']).to eq('Spooky rainbow')
    end
  end

  context '#create' do
    it 'creates the best poptart' do
      #when pass id before format it's in the route, and when after the format it's like a query or form data
      post :create, format: :json, poptart: { flavor: 'boston creme', sprinkles: 'black and white' }
      expect(response).to have_http_status(:created)
      poptart_response = JSON.parse(response.body)

      expect(poptart_response['poptart']['flavor']).to eq('boston creme')
      expect(poptart_response['poptart']['sprinkles']).to eq('black and white')
    end
  end

  context '#update' do
    it 'updates a poptart' do
      poptart = Poptart.create(flavor: 'plain', sprinkles: 'none')

      put :update, id: poptart.id, format: :json, poptart: { flavor: 'strawberry shortcake', sprinkles: 'red'}

      expect(response).to have_http_status(:no_content)
      expect(poptart.reload.flavor).to eq('strawberry shortcake')
      expect(poptart.sprinkles).to eq('red')
    end
  end

  context '#destroy' do
    it 'destroy the plain poptarts' do
      poptart = Poptart.create(flavor: 'plain', sprinkles: 'none')

      expect {
        delete :destroy, id: poptart.id, format: :json
      }.to change { Poptart.count }.from(1).to(0)

      expect(response).to have_http_status(:no_content)
    end
  end
end
