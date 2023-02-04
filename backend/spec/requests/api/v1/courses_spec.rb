# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::Courses', type: :request do
  describe 'POST /create' do
    before do
      sign_in user
    end

    # debugger
    let(:user) { create(:user) }
    let(:name) { 'TestCourse' }
    let(:params) { { name: } }

    it 'create a new courese' do
      post('/api/v1/courses', params:)
      expect(response).to have_http_status(:created)
    end
  end
end
