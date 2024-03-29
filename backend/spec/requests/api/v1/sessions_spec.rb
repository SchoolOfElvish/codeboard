# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::Sessions' do
  describe 'POST /sign_up' do
    let(:params) do
      { lastName: 'test_last_name', firstName: 'test_first_name', role: 'STUDENT', email: 'test@gmail.com',
        password:, passwordConfirmation: password_confirmation }
    end

    let(:password) { 'qwerty123' }
    let(:password_confirmation) { password }

    context 'when user already exists' do
      before { create(:user, email: params[:email]) }

      it 'returns an error' do
        post('/api/v1/sign-up', params:)
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context 'when user does not exist' do
      it 'creates a new user' do
        post('/api/v1/sign-up', params:)
        expect(response).to have_http_status(:created)
      end
    end

    context 'when password and password_confirmation do not match' do
      let(:password_confirmation) { "#{password}1" }
      let(:result) { { 'error' => { 'password_confirmation' => ["doesn't match Password"] } } }

      it "doesn't create a new user" do
        post('/api/v1/sign-up', params:)
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'returns an error' do
        post('/api/v1/sign-up', params:)
        expect(JSON.parse(response.body)).to eq(result)
      end
    end
  end

  describe 'POST /refresh' do
    let(:user) { create(:user) }
    let(:issuer) { Jwt::Issuer.call(user) }

    context 'when token and refresh token are valid' do
      let(:params) do
        {
          token: issuer[0],
          refreshToken: issuer[1].token
        }
      end

      it 'returns 201 OK' do
        post('/api/v1/refresh', params:)
        expect(response).to have_http_status(:created)
      end

      it 'returns new token pair' do
        post('/api/v1/refresh', params:)
        expect(JSON.parse(response.body)).to include({ 'token' => a_kind_of(String),
                                                       'refresh_token' => a_kind_of(String) })
      end
    end

    context 'when token and refresh token are not valid' do
      let(:params) do
        {
          token: 'dasd',
          refreshToken: 'dsda'
        }
      end

      it 'returns unprocessable_entity' do
        post('/api/v1/refresh', params:)
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'returns an error' do
        post('/api/v1/refresh', params:)
        expect(JSON.parse(response.body)).to eq({ 'error' => 'token_cannot_be_decoded' })
      end
    end
  end

  describe 'DELETE /sign_out' do
    let(:user) { create(:user) }
    let(:headers) { auth_header_for(user) }

    context 'when user authenticated' do
      it 'sign out request successfull' do
        delete('/api/v1/sign-out', headers:)
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when user is sign out' do
      let(:token) { Jwt::Authenticator.authenticate_header(headers) }
      let(:decoded_token) { Jwt::Decoder.decode!(token) }

      it 'token is in blacklist' do
        delete('/api/v1/sign-out', headers:)
        expect(decoded_token[:user_id]).to eq(BlacklistedToken.last.user_id)
      end
    end
  end
end
