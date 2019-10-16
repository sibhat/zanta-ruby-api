# # frozen_string_literal: true
#
# require 'rails_helper'
#
# RSpec.describe 'POST /api/v1/token', type: :request do
#   let(:url) { '/api/v1/token' }
#   let(:user) do
#     {
#         email: 'user@example.com',
#         code: "1213asdasdasd123123123asdasdasdsd"
#     }
#   end
#   let(:params) { { code: "4/rgFxlEHJupbUDKWuibEMkUzQj6z5nkNX8Sv6JpyYiQYVdfn6LPbP7hY2pY8CwneiWMKwYBCICKXMwuDoosH4w0E" } }
#
#   context 'valid user' do
#     before { post url, params: params }
#
#     it 'returns 200' do
#       puts response.body
#       expect(response.status).to eq 200
#     end
#
#     # it 'returns a new user' do
#     #   response_body = JSON.parse(response.body).deep_symbolize_keys
#     #   expect(response_body[:email]).to eq(user[:email])
#     # end
#     # it 'return Authorization in header' do
#     #   response_header = response.header.deep_symbolize_keys
#     #   expect(response_header[:Authorization].present?).to eq(true)
#     # end
#   end
#   # context 'inValid user' do
#   #   before { post url, params: {email: 'email@yao.com'}  }
#   #
#   #   it 'returns 422' do
#   #     expect(response.status).to eq 422
#   #   end
#   #
#   #   it 'returns a new user' do
#   #     response_body = JSON.parse(response.body).deep_symbolize_keys
#   #     expect(response_body[:email].present?).to eq(false)
#   #   end
#   #   it 'return Authorization in header' do
#   #     response_header = response.header.deep_symbolize_keys
#   #     expect(response_header[:Authorization].present?).to eq(false)
#   #   end
#   # end
# end