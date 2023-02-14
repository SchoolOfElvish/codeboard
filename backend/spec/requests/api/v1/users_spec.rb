# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::Sessions' do
  describe 'PUT /me' do
    let(:params) do
      { user:, birthdate: }
    end
    let(:password_confirmation) { password }
    let(:birthdate) { nil }
    let(:user) { create(:user) }

    before { user }

    context 'when birthdate is not nil' do
      it 'returns an 204' do
        put('/api/v1//users/me', headers: auth_header_for(user), params:)
        expect(response).to have_http_status(:no_content)
      end
    end

    context 'when birthdate is provided' do
      let(:birthdate) { Time.zone.today }

      it 'updates the user birthdate' do
        put('/api/v1//users/me', headers: auth_header_for(user), params:)
        expect(user.reload.birthdate).to eq(birthdate)
      end
    end
  end
end
