# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::Lessons', type: :request do
  describe 'POST /api/v1/courses/:course_id/lessons' do
    let(:user) { create(:user) }
    let(:headers) { auth_header_for(user) }
    let(:course) { create(:course, name: 'Test Course') }
    let(:params) { { course_id: course.id, title: 'dsa' } }

    it 'creates a new lesson' do
      post "/api/v1/courses/#{course.id}/lessons", params: params, headers: headers
      expect(response).to have_http_status(:created)
    end
  end
end
