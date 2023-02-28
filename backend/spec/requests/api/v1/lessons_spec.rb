# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::Lessons' do
  describe 'POST /api/v1/courses/:course_id/lessons' do
    let(:user) { create(:user) }
    let(:headers) { auth_header_for(user) }
    let(:course) { create(:course, name: 'TestCourse') }
    let(:params) { { course_id: course.id, title: 'TestTitle', description: 'TestDescription' } }

    it 'creates a new lesson' do
      post("/api/v1/courses/#{course.id}/lessons", params:, headers:)
      expect(response).to have_http_status(:created)
    end

    context 'when name is empty' do
      let(:params) { { course_id: course.id, title: '', description: 'dsad' } }

      it "dosen't create a new lessom" do
        post("/api/v1/courses/#{course.id}/lessons", params:, headers:)
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
