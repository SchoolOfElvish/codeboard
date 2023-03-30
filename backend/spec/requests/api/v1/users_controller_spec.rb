# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::UsersController' do
  describe 'GET #show' do
    let(:user) { create(:user) }
    let(:user_data) do
      {
        'first_name' => user.first_name,
        'last_name' => user.last_name,
        'role' => user.role,
        'created_at' => user.created_at.to_date.to_s,
        'about_info' => user.about_info
      }
    end
    let(:headers) { auth_header_for(user) }

    context 'when the user exists' do
      before { get("/api/v1/users/#{user.id}", headers:) }

      it 'returns an 200' do
        expect(response).to have_http_status(:ok)
      end

      it 'returns correct format & charset' do
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end

      it 'returns the correct user data' do
        expect(JSON.parse(response.body)).to eq(user_data)
      end
    end

    context 'when the user does not exist' do
      before { get('/api/v1/users/-1', headers:) }

      it 'returns status code 404' do
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
