# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::Courses', type: :request do
  describe 'POST /create' do
    let!(:token) { Jwt::Issuer.call(user)[0] }
    let(:user) { create(:user) }
    let(:name) { 'TestCourse' }
    let(:params) { { name: } }
    let(:headers) { {'Authorization' => "Bearer #{token}"} }

    it 'create a new courese' do
      post('/api/v1/courses', params:, headers:)
      expect(response).to have_http_status(:created)
    end
  end
end
