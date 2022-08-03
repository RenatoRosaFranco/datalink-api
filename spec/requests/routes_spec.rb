# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "Routes API", type: :request do
  let!(:routes)  { FactoryBot.create_list(:route, 10) }
  let(:route_id) { routes.first.id }

  describe 'GET /routes' do
    before { get '/api/v1/routes' }

    it 'returns all routes', :aggregate_failures do
      expect(JSON.parse(response.body)).to_not be_empty
      expect(JSON.parse(response.body)["routes"].size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /routes/:id' do
    before { get "/api/v1/routes/#{route_id}" }

    context 'when the route exists' do
      it 'returns the route', :aggregate_failures do
        expect(JSON.parse(response.body)).not_to be_empty
        expect(JSON.parse(response.body)['route']['id']).to eq(route_id)
      end 
    end

    context 'when the route doesn not exist' do
      let(:err_msg) { "Couldn't find Route with 'id'=#{route_id}" }
      let(:route_id) { 300 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message', :aggregate_failures do
        expect(JSON.parse(response.body)['message']).to be_present
        expect(JSON.parse(response.body)['message']).to match(err_msg)
      end
    end
  end

  describe 'POST /routes' do
    before { post '/api/v1/routes', params: route }

    context 'when params are valid' do
      let(:route) { attributes }

      let(:attributes) do
        {
          "route": {
            "name": "Turismo I"
          }
        }
      end

      it 'creates a route' do
        expect(JSON.parse(response.body)['route']).to be_present
        expect(JSON.parse(response.body).size).to eq(1)
      end

      it 'returns a status code 201' do
        expect(response).to have_http_status(201)
      end
    end


    context 'when the params are not valid' do
      let(:route) { attributes }

      let(:attributes) do
        {
          "route": {
            "name": ""
          }
        }
      end

      it 'fails to create a route' do
        expect(JSON.parse(response.body)['errors']).to be_present
        expect(JSON.parse(response.body)['errors'].size).to eq(1)
      end

      it 'returns a status code 422' do
        expect(response).to have_http_status(422)
      end
    end
  end

  describe 'PUT /routes/:id' do
    let(:attributes) do
      {
        "route": {
          "name": "Tursimo - São Borja II"
        }
      }
    end

    context 'when params are valid' do
      before { put "/api/v1/routes/#{route_id}", params: attributes }

      it 'update the route' do
        expect(JSON.parse(response.body)).to_not be_empty
      end

      it 'return status code 202' do
        expect(response).to have_http_status(202)
      end
    end

    context 'when params are invalid' do
      before { put "/api/v1/routes/#{route_id}", params: attributes }
      
      let(:attributes) do
        {
          "route": {
            "name": ""
          }
        }
      end

      it 'fails to update route', :aggregate_failures do
        expect(JSON.parse(response.body)['errors']).to be_present
        expect(JSON.parse(response.body)['errors'].size).to eq(1)
      end

      it 'return status code 422' do
        expect(response).to have_http_status(422)
      end
    end
  end

  describe 'DELETE /routes/:id' do
    before { delete "/api/v1/routes/#{route_id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
