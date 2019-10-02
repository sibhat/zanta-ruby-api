# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'POST users/sign_up', type: :request do
  let(:url) { '/users/sign_up' }
  let(:user) do
    {
      email: 'user@example.com',
      password: 'password'
    }
  end
  let(:params) { { user: user } }

  context 'valid user' do
    before { post url, params: params }

    it 'returns 201' do
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
    before { post url, params: {email: 'email@yao.com'}  }

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