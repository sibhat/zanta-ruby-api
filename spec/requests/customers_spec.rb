# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Customer Rspec', type: :request do
  let(:url) { '/api/v1/register/customers' }
  let(:user) do
    {
        email: 'user@example.com',
        password: 'password'
    }
  end
  let(:params) { {customer: user} }

  context 'Register Customers' do
    context 'valid customer' do
      before { post url, params: params }

      it 'returns 201' do
        expect(response.status).to eq 201
      end

      it 'returns newly created customer id' do
        response_body = JSON.parse(response.body).deep_symbolize_keys
        expect(response_body[:id]).not_to be(nil)
      end
      it 'return Authorization in header' do
        response_header = response.header.deep_symbolize_keys
        expect(response_header[:Authorization].present?).to eq(true)
      end
    end
    context 'inValid customer' do
      before { post url, params: {customer: {email: 'email@yao.com'}} }

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
  context 'Update Customer' do
    let(:url) { '/api/v1/customers' }
    let(:user) { create(:user) }
    let(:customer) { create(:customer) }
    context 'Get Customer by ID ' do
      before { get "#{url}/#{customer.id}" }
      it 'returns 200' do
        puts "#{url}/#{customer.id}"
        expect(response.status).to eq 200
      end
      it 'should return the right Customer associated with the id' do
        response_body = JSON.parse(response.body).deep_symbolize_keys
        expect(response_body[:id]).to eq(customer.id)
      end
    end
    context 'Update Customer by ID ' do
      let(:update_customer) { {updated_at: 'sibhat'} }
      before do
        patch "#{url}/#{customer.id}", params: {customer: update_customer}
      end
      # it "should return the right Customer associated with the id" do
      #   response_body = JSON.parse(response.body).deep_symbolize_keys
      #   expect(response_body[:id]).to eq(customer.id)
      # end
      it 'returns 200' do
        expect(response.status).to eq 200
      end
    end
    context 'Delete Customer by ID ' do
      before do
        delete "#{url}/#{customer.id}"
      end
      it 'returns 204' do
        puts response.body
        expect(response.status).to eq 204
      end
    end
  end
end