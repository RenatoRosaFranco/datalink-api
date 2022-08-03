# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "Pages API", type: :request do
  let!(:pages) { create_list(:page, 2) }
  let(:page)   { pages.first }

  describe "GET /pages" do
    before { get "/api/v1/pages" }

    it 'return all pages', :aggregate_failures do
      expect(JSON.parse(response.body)).to_not be_empty
      expect(JSON.parse(response.body)['pages'].size).to eq(2)
    end
    
    it 'return status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /pages/:id' do
    before { get "/api/v1/pages/#{page.id}" }

    context 'when the page exists' do
      it 'return the page' do
        expect(JSON.parse(response.body)).not_to be_empty
        expect(JSON.parse(response.body)['page']['id']).to eq(page.id)
      end
    end

    context 'when the page does not exist' do
      let(:place_id) { 300 }
      let(:err_msg) { "Couldn't find Place with 'id'=#{place_id}" }

      before { get "/api/v1/places/#{place_id}" }

      it 'returns status 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message', :aggregate_failures do
        expect(JSON.parse(response.body)['message']).to be_present
        expect(JSON.parse(response.body)['message']).to match(err_msg)
      end
    end
  end

  describe 'POST /pages' do
    before { post "/api/v1/pages", params: attributes }

    let(:place) { create(:place, name: "Mecautor") }

    context 'when params are valid' do
      let(:attributes) do
        {
          "page": {
            "vpath": "https://youtube.com/watch=29iaASke",
            "about": "Fabrica da Wolkswagem",
            "facebook": "https://facebook.com/mecautor",
            "instagram": "https://instagram.com/mecautor",
            "place_id": place.id
          }
        }
      end

      it 'creates a page', :aggregate_failures do
        expect(JSON.parse(response.body)['page']).to be_present
        expect(JSON.parse(response.body).size).to eq(1)
      end

      it 'returns a status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when params are invalid' do
      let(:attributes) do
        {
          "page": {
            "vpath": "https://youtube.com/watch=29iaASke",
            "about": "Fabrica da Wolkswagem",
            "facebook": "https://facebook.com/mecautor",
            "instagram": "https://instagram.com/mecautor",
            "place_id": nil
          }
        }
      end

      it 'fails to create a page', :aggregate_failures do
        expect(JSON.parse(response.body)['errors']).to be_present
        expect(JSON.parse(response.body)['errors'].size).to eq(1)
      end

      it 'returns a status code 422' do
        expect(response).to have_http_status(422)
      end
    end
  end

  describe 'PUT /pages/:id' do
    before { put "/api/v1/pages/#{page.id}", params: attributes }

    let(:place) { page.place }

    context 'when params are valid' do
      let(:attributes) do
        {
          "page": {
            "vpath": "https://youtube.com/watch=29iaASke",
            "about": "Fabrica da Wolkswagem, São Borja",
            "facebook": "https://facebook.com/mecautor",
            "instagram": "https://instagram.com/mecautor",
            "place_id": place.id
          }
        }
      end

      it 'update the page' do
        expect(JSON.parse(response.body)).to_not be_empty
      end

      it 'return status code 202' do
        expect(response).to have_http_status(202)
      end
    end

    context 'when params are invalid' do
      let(:attributes) do
        {
          "page": {
            "vpath": "https://youtube.com/watch=29iaASke",
            "about": "Fabrica da Wolkswagem, São Borja",
            "facebook": "https://facebook.com/mecautor",
            "instagram": "https://instagram.com/mecautor",
            "place_id": nil
          }
        }
      end

      it 'fails to update page' do
        expect(JSON.parse(response.body)['errors']).to be_present
        expect(JSON.parse(response.body)['errors'].size).to eq(1)
      end

      it 'return status code 422' do
        expect(response).to have_http_status(422)
      end
    end
  end

  describe 'DELETE /pages/:id' do
    before { delete "/api/v1/pages/#{page.id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
