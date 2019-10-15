# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Business', type: :request do
  describe ' Register /api/v1/register/businesses' do
    let(:url) { '/api/v1/register/businesses' }
    let(:user) { create(:user) }
    let(:new_business) { {email: 'business@test.com', password: '123456'} }

    context 'valid user' do
      before { post url, params: {business: new_business} }

      it 'returns 201' do
        expect(response.status).to eq 201
      end

      it 'should return valid user_id' do
        response_body = JSON.parse(response.body).deep_symbolize_keys
        expect(response_body[:user_id]).not_to be(nil)
      end
      it 'return Authorization in header' do
        response_header = response.header.deep_symbolize_keys
        expect(response_header[:Authorization].present?).to eq(true)
      end
    end
    context 'inValid user' do
      before { post url, params: {business: {email: 'email@yao.com'}} }

      it 'returns 422' do
        expect(response.status).to eq 422
      end

      it 'returns a new user' do
        response_body = JSON.parse(response.body).deep_symbolize_keys
        expect(response_body[:email].present?).to eq(false)
      end
      it 'return Authorization in header' do
        response_header = response.header.deep_symbolize_keys
        expect(response_header[:Authorization].present?).to eq(false)
      end
    end
  end
  describe 'CRUD opration  ' do
    let(:url) { '/api/v1/businesses' }
    let(:user) { create(:user) }

    let(:params) { create(:business) }

    context 'Get Business by ID' do
      before { get "#{url}/#{params.id}" }
      it 'Should return status code 200' do
        puts response.body
        expect(response.status).to eq(200)
      end
    end
    context 'Patch Business by ID' do
      let(:update_business) { {rating: 2} }
      before do
        patch "#{url}/#{params.id}",
              params: {business: update_business}
      end
      it 'should return status code 200' do
        expect(response.status).to eq(200)
      end
    end
    context 'Delete Business by ID' do
      before { delete "#{url}/#{params.id}" }
      it 'should return status code 204' do
        expect(response.status).to eq(204)
      end
    end
  end
end
