# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "Cities API", type: :request do
  let!(:cities) { create_list(:city, 2) }
  let(:city)    { cities.first }
  let(:state)   { city.state }

  describe 'GET /cities' do
    before { get '/api/v1/cities' }

    it 'return all cities', :aggregate_failures do
      expect(JSON.parse(response.body)).to_not be_empty
      expect(JSON.parse(response.body)['cities'].size).to eq(2)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /cities/:id' do
    before { get "/api/v1/cities/#{city.id}" }

    context 'when the city exists' do
      it 'returns the city', :aggregate_failures do
        expect(JSON.parse(response.body)).not_to be_empty
        expect(JSON.parse(response.body)['city']['id']).to eq(city.id)
      end
    end

    context 'when the city does not exist' do
      let(:city_id) { 300 }
      let(:err_msg) { "Couldn't find City with 'id'=#{city_id}" }

      before { get "/api/v1/cities/#{city_id}" }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message', :aggregate_failures do
        expect(JSON.parse(response.body)['message']).to be_present
        expect(JSON.parse(response.body)['message']).to match(err_msg)
      end
    end
  end

  describe 'POST /cities' do
    before { post "/api/v1/cities", params: attributes }

    context 'when params are valid' do
      let(:state) { create(:state, name: 'Rio Grande do Sul', acronym: 'RS') }
      let(:attributes) do
        {
          "city": {
            "name": "Porto Alegre",
            "capital": true,
            "state_id": state.id
          }
        }
      end

      it 'create a city', :aggregate_failures do
        expect(JSON.parse(response.body)['city']).to be_present
        expect(JSON.parse(response.body).size).to eq(1)
      end

      it 'returns a status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when params are invalid' do
      let(:attributes) do
        {
          "city": {
            "name": "Porto Alegre",
            "capital": true,
            "state_id": nil
          }
        }
      end

      it 'fails to create city', :aggregate_failures do
        expect(JSON.parse(response.body)['errors']).to be_present
        expect(JSON.parse(response.body)['errors'].size).to eq(1)
      end

      it 'returns a status code 422' do
        expect(response).to have_http_status(422)
      end
    end
  end

  describe 'PUT /cities/:id' do
    context 'when params are valid' do
      before { put "/api/v1/cities/#{city.id}", params: attributes }
      
      let(:attributes) do
        {
          "city": {
            "name": "Santiago",
            "capital": true,
            "state_id": state.id
          }
        }
      end

      it 'update the city' do
        expect(JSON.parse(response.body)).to_not be_empty
      end

      it 'return status code 202' do
        expect(response).to have_http_status(202)
      end
    end

    context 'when params are invalid' do
      before { put "/api/v1/cities/#{city.id}", params: attributes }

      let(:attributes) do
        {
          "city": {
            "name": "São Francisco de Assis",
            "capital": false,
            "state_id": state.id
          }
        }
      end

      it 'fails to update city', :aggregate_failures do
        expect(JSON.parse(response.body)['errors']).to be_present
        expect(JSON.parse(response.body)['errors'].size).to eq(1)
      end

      it 'return status code 422' do
        expect(response).to have_http_status(422)
      end
    end
  end

  describe 'DELETE /cities/:id' do
    before { delete "/api/v1/cities/#{city.id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
