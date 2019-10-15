# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'POST /api/v1/login', type: :request do
  let(:url) { '/api/v1/login' }
  let(:user) { create(:user) }
  let(:params) do
    {
      user: {
        email: user.email,
        password: user.password
      }
    }
  end

  context 'valid login request' do
    before do
      post url, params: params
    end
    it 'should return 201 status code' do
      expect(response.status).to eq 201
    end
    it 'returns a new user' do
      response_body = JSON.parse(response.body).deep_symbolize_keys
      expect(response_body[:email]).to eq(user[:email])
    end
    it 'return Authorization in header' do
      response_header = response.header.deep_symbolize_keys
      expect(response_header[:Authorization].present?).to eq(true)
    end
  end
  context 'inValid user' do
    before { post url, params: { email: 'email@yao.com' } }

    it 'returns 401' do
      expect(response.status).to eq 401
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