# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "Regions API", type: :request do
  let!(:regions) { create_list(:region, 2) }
  let(:region)   { regions.first }

  describe "GET /regions" do
    before { get '/api/v1/regions' }

    it 'returns all regions', :aggregate_failures do
      expect(JSON.parse(response.body)).to_not be_empty
      expect(JSON.parse(response.body)['regions'].size).to eq(2)
    end

    it 'retuns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /regions/:id' do
    before { get "/api/v1/regions/#{region.id}" }

    context  'when the regions exists' do
      it 'returns the address', :aggregate_failures do
        expect(JSON.parse(response.body)).not_to be_empty
        expect(JSON.parse(response.body)['region']['id']).to eq(region.id)
      end
    end

    context 'when the region does not exist' do
      let(:region_id) { 300 }
      let(:err_msg) { "Couldn't find Region with 'id'=#{region_id}" }

      before { get "/api/v1/regions/#{region_id}" }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(JSON.parse(response.body)['message']).to be_present
        expect(JSON.parse(response.body)['message']).to match(err_msg)
      end
    end
  end

  describe 'POST /regions' do
    before { post "/api/v1/regions", params: attributes }

    context "when params are valid" do
      let(:attributes) do
        {
          "region": {
            "name": "Sul"
          }
        }
      end

      it 'create a region' do
        expect(JSON.parse(response.body)['region']).to be_present
        expect(JSON.parse(response.body).size).to eq(1)
      end

      it 'returns a status code 201' do
        expect(response).to have_http_status(201)
      end
    end
    
    context 'when params are invalid' do
      let(:attributes) do
        {
          "region": {
            "name": ""
          }
        }
      end

      it 'fails to create a region' do
        expect(JSON.parse(response.body)['errors']).to be_present
        expect(JSON.parse(response.body)['errors'].size).to eq(1)
      end
    end
  end

  describe 'PUT /regions/:id' do
    before { put "/api/v1/regions/#{region.id}", params: attributes }

    context 'when params are valid' do
      let(:attributes) do
        {
          "region": {
            "name": "Sudeste"
          }
        }
      end

      it 'update the region' do
        expect(JSON.parse(response.body)).to_not be_empty
      end

      it 'return status code 202' do
        expect(response).to have_http_status(202)
      end
    end

    context 'when params are invalid' do
      let(:attributes) do
        {
          "region": {
            "name": ""
          }
        }
      end

      it 'fails to update region', :aggregate_failures do
        expect(JSON.parse(response.body)['errors']).to be_present
        expect(JSON.parse(response.body)['errors'].size).to eq(1)
      end

      it 'return status code 422' do
        expect(response).to have_http_status(422)
      end
    end
  end

  describe 'DELETE /regions/:id' do
    before { delete "/api/v1/regions/#{region.id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
