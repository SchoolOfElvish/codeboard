# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::Sessions' do
  let(:role) { 1 }
  let(:password) { 'qwerty123' }
  let(:password_confirmation) { password }

  describe 'POST /sign_up' do
    let(:params) do
      { lastName: 'test_last_name', firstName: 'test_first_name', role:, email: 'test@gmail.com', password:,
        passwordConfirmation: password_confirmation }
    end

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
end
