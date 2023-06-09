# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::LessonsController' do
  describe 'POST /api/v1/courses/:course_id/lessons' do
    let(:teacher) { create(:teacher) }
    let(:headers) { auth_header_for(teacher) }
    let(:course) { create(:course, name: 'TestCourse', user_id: teacher.id) }
    let(:params) { { course_id: course.id, title: 'TestTitle', description: 'TestDescription' } }

    it 'creates a new lesson' do
      post("/api/v1/courses/#{course.id}/lessons", params:, headers:)
      expect(response).to have_http_status(:created)
    end

    context 'when params are incorect' do
      let(:params) { { course_id: course.id, title: '', description: '' } }

      it "dosen't create a new lesson" do
        post("/api/v1/courses/#{course.id}/lessons", params:, headers:)
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context 'when other user trying to create lesson' do
      let(:other_theatcher) { create(:teacher) }
      let(:headers) { auth_header_for(other_theatcher) }

      it "dosen't create a new lesson" do
        post("/api/v1/courses/#{course.id}/lessons", params:, headers:)
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'GET /api/v1/courses/:course_id/lessons' do
    let(:teacher) { create(:teacher) }
    let(:headers) { auth_header_for(teacher) }
    let(:course) { create(:course, user_id: teacher.id) }
    let(:course2) { create(:course, user_id: teacher.id) }

    before do
      create_list(:lesson, 3, course_id: course.id)
      create_list(:lesson, 2, course_id: course2.id)
    end

    it 'return all lessons attached to the course' do
      get("/api/v1/courses/#{course.id}/lessons", headers:)
      expect(JSON.parse(response.body).length).to eq(3)
    end
  end
end
