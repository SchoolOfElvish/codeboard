# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::Sessions' do
  describe 'POST /me' do
    let(:params) do
      { lastName: 'test_last_name', firstName: 'test_first_name', role: 'STUDENT', email: 'test@gmail.com',
        password:, passwordConfirmation: password_confirmation, birthdate: birthdate }
    end

    let(:password) { 'qwerty123' }
    let(:password_confirmation) { password }
    let(:birthdate) { nil }

    before { create(:user, email: params[:email]) }

    context 'when birthdate is not provided' do
      it 'returns an error' do
        post('/api/v1/update', birthdate: nil )
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context 'when birthdate is provided' do
      let(:birthdate) { Time.zone.now }

      it 'updates the user birthdate' do
        post('/api/v1/update', birthdate: )
        expect(response).to have_http_status(:no_content)
        expect(current_user.reload.birthdate).to eq(birthdate)
      end
    end
  end
end