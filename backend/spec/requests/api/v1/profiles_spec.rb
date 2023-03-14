# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::Profiles' do
  describe 'PUT /me' do
    let(:user_params) do
      {
        first_name: user.first_name,
        last_name: user.last_name,
        birthdate: nil
      }
    end

    let(:user) { create(:user) }
    let(:headers) { auth_header_for(user) }

    context 'when birthdate is not nil' do
      it 'returns an 200' do
        put('/api/v1/users/me', params: user_params, headers:)
        expect(response).to have_http_status(:no_content)
      end
    end

    context 'when birthdate is provided' do
      let(:user_params) do
        {
          first_name: user.first_name,
          last_name: user.last_name,
          birthdate: Time.zone.today
        }
      end

      it 'updates the user birthdate' do
        put('/api/v1/users/me', params: user_params, headers:)
        expect(user.reload.birthdate).to eq(user_params[:birthdate])
      end
    end

    context 'when user provide new valid full name' do
      let(:user_params) do
        {
          first_name: 'Newname',
          last_name: 'Newname',
          birthdate: nil
        }
      end

      it 'update first name' do
        put('/api/v1/users/me', params: user_params, headers:)
        expect(user.reload.first_name).to eq(user_params[:first_name])
      end

      it 'update last name' do
        put('/api/v1/users/me', params: user_params, headers:)
        expect(user.reload.last_name).to eq(user_params[:last_name])
      end
    end

    context 'when user provide nil full name' do
      let(:user_params) do
        {
          first_name: nil,
          last_name: nil,
          birthdate: nil
        }
      end

      it 'return error' do
        put('/api/v1/users/me', params: user_params, headers:)
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
