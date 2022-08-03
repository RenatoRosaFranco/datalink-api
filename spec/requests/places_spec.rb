# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "Places API", type: :request do
  let!(:places) { create_list(:place, 2) }
  let(:place)   { places.first }

  describe "GET /places" do
    before { get '/api/v1/places' }

    it 'return all places', :aggregate_failures do
      expect(JSON.parse(response.body)).to_not be_empty
      expect(JSON.parse(response.body)['places'].size).to eq(2)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /places/:id' do
    before { get "/api/v1/places/#{place.id}" }

    context "when the state exist" do
      it 'returns the place', :aggregate_failures do
        expect(JSON.parse(response.body)).not_to be_empty
        expect(JSON.parse(response.body)['place']['id']).to eq(place.id)
      end
    end

    context 'when the place does not exist' do
      let(:place_id) { 300 }
      let(:err_msg) { "Couldn't find Place with 'id'=#{place_id}" }

      before { get "/api/v1/places/#{place_id}" }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it "returns a not found message", :aggregate_failures do
        expect(JSON.parse(response.body)['message']).to be_present
        expect(JSON.parse(response.body)['message']).to match(err_msg)
      end
    end
  end

  describe 'POST /places' do
    before { post "/api/v1/places", params: attributes }

    let(:attributes) do
      {
        "place": {
          "name": "Fernan",
          "kind": "Company"
        }
      }
    end

    context 'when params are valid' do
      it 'create a place' do
        expect(JSON.parse(response.body)['place']).to be_present
        expect(JSON.parse(response.body).size).to eq(1)
      end
      
      it 'returns a status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when params are invalid' do
      let(:attributes) do
        {
          "place": {
            "name": "",
            "kind": "Company"
          }
        }
      end

      it 'fails to create place' do
        expect(JSON.parse(response.body)['errors']).to be_present
        expect(JSON.parse(response.body)['errors'].size).to eq(1)
      end

      it 'returns a status code 422' do
        expect(response).to have_http_status(422)
      end
    end
  end

  describe 'PUT /places/:id' do
    context 'when params are valid' do
      before { put "/api/v1/places/#{place.id}", params: attributes }

      let(:attributes) do
        {
          "place": {
            "name": "Mecautor",
            "kind": "Company"
          }
        }
      end

      it 'update the place' do
        expect(JSON.parse(response.body)).to_not be_empty
      end

      it 'return status code 202' do
        expect(response).to have_http_status(202)
      end
    end

    context 'when params are invalid' do
      before { put "/api/v1/places/#{place.id}", params: attributes }

      let(:attributes) do
        {
          "place": {
            "name": "",
            "kind": "Company"
          }
        }
      end

      it 'fails to update place', :aggregate_failures do
        expect(JSON.parse(response.body)['errors']).to be_present
        expect(JSON.parse(response.body)['errors'].size).to eq(1)
      end

      it 'return status code 422' do
        expect(response).to have_http_status(422)
      end
    end
  end

  describe 'DELETE /places/:id' do
    before { delete "/api/v1/places/#{place.id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
