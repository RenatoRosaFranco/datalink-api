# frozen_string_literal:

require 'rails_helper'

RSpec.describe "Addresses API", type: :request do
  let!(:addresses) { create_list(:address, 2) }
  let(:address)    { addresses.first }

  describe 'GET /addresses' do
    before { get '/api/v1/addresses' }

    it 'return all addresses', :aggregate_failures do
      expect(JSON.parse(response.body)).to_not be_empty
      expect(JSON.parse(response.body)['addresses'].size).to eq(2)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /addresses/:id' do
    before { get "/api/v1/addresses/#{address.id}" }

    context 'when the address exists' do
      it 'returns the address', :aggregate_failures do
        expect(JSON.parse(response.body)).not_to be_empty
        expect(JSON.parse(response.body)['address']['id']).to eq(address.id)
      end
    end

    context 'when the address does not exist' do
      let(:address_id) { 300 }
      let(:err_msg) { "Couldn't find Address with 'id'=#{address_id}" }
    
      before { get "/api/v1/addresses/#{address_id}" }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message', :aggregate_failures do
        expect(JSON.parse(response.body)['message']).to be_present
        expect(JSON.parse(response.body)['message']).to match(err_msg)
      end
    end
  end

  describe 'POST /addresses' do
    before { post "/api/v1/addresses", params: address }
      
    let!(:place) { create(:place) }

    context 'when params are valid' do
      let(:address) do 
        {
          "address": {
            "location": "Mecautor",
            "number": 250,
            "place_id": place.id
          }
        }
      end

      it 'create a address' do
        expect(JSON.parse(response.body)['address']).to be_present
        expect(JSON.parse(response.body).size).to eq(1)
      end

      it 'returns a status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when params are invalid' do
      let(:address) { attributes }
      let(:attributes) do
        {
          "address": {
            "location": "ACISB",
            "number": 878,
            "place_id": nil
          }
        }
      end

      it 'fails to create a address' do
        expect(JSON.parse(response.body)['errors']).to be_present
        expect(JSON.parse(response.body)['errors'].size).to eq(1)
      end

      it 'returns a status code 422' do
        expect(response).to have_http_status(422)
      end
    end
  end

  describe 'PUT /addresses/:id' do
    before { put "/api/v1/addresses/#{address.id}", params: attributes }

    context 'when params are valid' do
      let(:attributes) do
        {
          "address": {
            "location": "Museu Getulio Vargas",
            "number": 456,
            "place_id": address.place_id
          }
        }
      end

      it 'update the address' do
        expect(JSON.parse(response.body)).to_not be_empty
      end

      it 'return status code 202' do
        expect(response).to have_http_status(202)
      end
    end

    context 'when params are invalid' do
      let(:attributes) do
        {
          "address": {
            "location": "Museu Getulio Vargas",
            "number": nil,
            "place_id": address.place_id
          }
        }
      end

      it 'fails to update address', :aggregate_failures do
        expect(JSON.parse(response.body)['errors']).to be_present
        expect(JSON.parse(response.body)['errors'].size).to eq(1)
      end

      it 'return status code 422' do
        expect(response).to have_http_status(422)
      end
    end
  end

  describe 'DELETE /addresses/:id' do
    before { delete "/api/v1/addresses/#{address.id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
