# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "States API", type: :request do
  let!(:states) { create_list(:state, 2) }
  let(:state)   { states.first }
  let(:region)  { state.region }

  describe "GET /states" do
    before { get '/api/v1/states' }

    it 'return all states', :aggregate_failures do
      expect(JSON.parse(response.body)).to_not be_empty
      expect(JSON.parse(response.body)['states'].size).to eq(2)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /states/:id' do
    context 'when the state exists' do
      before { get "/api/v1/states/#{state.id}" }

      it 'returns the state', :aggregate_failures do
        expect(JSON.parse(response.body)).not_to be_empty
        expect(JSON.parse(response.body)['state']['id']).to eq(state.id)
      end
    end

    context 'when the state does not exist' do
      let(:state_id) { 300 }
      let(:err_msg) { "Couldn't find State with 'id'=#{state_id}" }

      before { get "/api/v1/states/#{state_id}" } 
      
      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message', :aggregate_failures do
        expect(JSON.parse(response.body)['message']).to be_present
        expect(JSON.parse(response.body)['message']).to match(err_msg)
      end
    end
  end

  describe 'POST /states' do
    before { post "/api/v1/states", params: attributes }

    let!(:place) { create(:place) }

    context "when params are valid" do
      let(:attributes) do
        {
          "state": {
            "name": "Rio Grande do Sul",
            "acronym": "RS",
            "region_id": region.id
          }
        }
      end

      it 'create state' do
        expect(JSON.parse(response.body)['state']).to be_present
        expect(JSON.parse(response.body).size).to eq(1)
      end

      it 'returns a status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when params are invalid' do
      let(:attributes) do
        {
          "state": {
            "name": "Santa Catarina",
            "acronym": "RS",
            "region_id": nil
          }
        }
      end

      it 'fails to create a state' do
        expect(JSON.parse(response.body)['errors']).to be_present
        expect(JSON.parse(response.body)['errors'].size).to eq(1)
      end

      it 'returns a status code 422' do
        expect(response).to have_http_status(422)
      end
    end
  end

  describe 'PUT /states/:id' do
    context 'when params are valid' do
      before { put "/api/v1/states/#{state.id}", params: attributes }

      let(:attributes) do
        {
          "state": {
            "name": "Santa Catarina",
            "acronym": "SC",
            "region_id": region.id
          }
        }
      end

      it 'update the state', :aggregate_failures do
        expect(JSON.parse(response.body)).to_not be_empty
        expect(JSON.parse(response.body)['state']['name']).to eq(attributes[:state][:name])
        expect(JSON.parse(response.body)['state']['acronym']).to eq(attributes[:state][:acronym])
        expect(JSON.parse(response.body)['state']['region_id']).to eq(attributes[:state][:region_id])
      end

      it 'return status code 202' do
        expect(response).to have_http_status(202)
      end
    end

    context 'when params are invalid' do
      before { put "/api/v1/states/#{state.id}", params: attributes }

      let(:attributes) do
        {
          "state": {
            "name": "Rio Grande do Sul",
            "acronym": nil,
            "region_id": region.id
          }
        }
      end

      it 'fails to update state', :aggregate_failures do
        expect(JSON.parse(response.body)['errors']).to be_present
        expect(JSON.parse(response.body)['errors'].size).to eq(1)
      end

      it 'return status code 422' do
        expect(response).to have_http_status(422)
      end
    end
  end

  describe 'DELETE /states/:id' do
    before { delete "/api/v1/states/#{state.id}" }

    it 'retuns status code' do
      expect(response).to have_http_status(204)
    end
  end
 end
