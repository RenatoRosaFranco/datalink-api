# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "RoutePlaces API", type: :request do
  let!(:route_places) { create_list(:route_place, 2) }
  let(:route_place)   { route_places.first }

  describe "GET /route_places" do
    before { get '/api/v1/route_places' }

    it 'return all route_places', :aggregate_failures do
      expect(JSON.parse(response.body)).to_not be_empty
      expect(JSON.parse(response.body)['route_places'].size).to eq(2)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /route_places/:id' do
    before { get "/api/v1/route_places/#{route_place.id}" }

    context "when the route_palces exists" do
      it 'returns the route_place', :aggregate_failures do
        expect(JSON.parse(response.body)).not_to be_empty
        expect(JSON.parse(response.body)['route_place']['id']).to eq(route_place.id)
      end
    end

    context 'when the route_place does not exist' do
      let(:route_place_id) { 300 }
      let(:err_msg) { "Couldn't find RoutePlace with 'id'=#{route_place_id}" }

      before { get "/api/v1/route_places/#{route_place_id}" }

      it 'retuns a status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message', :aggregate_failures do
        expect(JSON.parse(response.body)['message']).to be_present
        expect(JSON.parse(response.body)['message']).to match(err_msg)
      end
    end
  end

  describe 'POST /route_places' do
    before { post "/api/v1/route_places", params: attributes }

    let!(:place) { create(:place) }

    context 'when params are valid' do
      let(:attributes) do
        {
          "route_place": {
            "route_id": route_place.route.id,
            "place_id": place.id
          }
        }
      end

      it 'create a route_place' do
        expect(JSON.parse(response.body)['route_place']).to be_present
        expect(JSON.parse(response.body).size).to eq(1)
      end

      it 'retuns a status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when params are invalid' do
      let(:attributes) do
        {
          "route_place": {
            "route_id": route_place.route.id,
            "place_id": nil
          }
        }
      end

      it 'fails to create route_place' do
        expect(JSON.parse(response.body)['errors']).to be_present
        expect(JSON.parse(response.body)['errors'].size).to eq(1)
      end

      it 'returns a status code 422' do
        expect(response).to have_http_status(422)
      end
    end
  end

  describe 'PUT /route_places/:id' do
    before { put "/api/v1/route_places/#{route_place.id}", params: attributes }

    context 'when params are valid' do
      let(:place) { create(:place) }

      let(:attributes) do
        {
          "route_place": {
            "route_id": route_place.route.id,
            "place_id": place.id
          }
        }
      end

      it 'update the route_place' do
        expect(JSON.parse(response.body)).to_not be_empty
      end

      it 'returns status code 202' do
        expect(response).to have_http_status(202)
      end
    end

    context 'when params are invalid' do
      let(:attributes) do
        {
          "route_place": {
            "route_id": route_place.route.id,
            "place_id": nil
          }
        }
      end

      it 'fails to update route_places', :aggregate_failures do
        expect(JSON.parse(response.body)['errors']).to be_present
        expect(JSON.parse(response.body)['errors'].size).to eq(1)
      end

      it 'return status code 422' do
        expect(response).to have_http_status(422)
      end
    end
  end

  describe 'DELETE /route_places/:id' do
    before { delete "/api/v1/route_places/#{route_place.id}"}
  
    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
