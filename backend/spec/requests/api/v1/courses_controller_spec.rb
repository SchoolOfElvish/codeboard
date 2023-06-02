# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::CoursesController' do
  describe 'POST /create' do
    let(:user) { create(:user) }
    let(:name) { 'TestCourse' }
    let(:params) { { name: } }
    let(:headers) { auth_header_for(user) }

    it 'create a new courese' do
      post('/api/v1/courses', params:, headers:)
      expect(response).to have_http_status(:created)
    end

    context 'when name is empty' do
      let(:name) { '' }

      it "dosen't create a new course" do
        post('/api/v1/courses', params:, headers:)
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'return an error' do
        post('/api/v1/courses', params:, headers:)
        expect(JSON.parse(response.body)['errors']).to match({ 'name' => ["can't be blank"] })
      end
    end
  end

  describe 'GET /index' do
    let(:teacher) { create(:teacher) }
    let(:student) { create(:user) }
    let!(:course) { create(:course, user: teacher) }
    let(:name) { course.name }
    let(:headers) { auth_header_for(teacher) }

    it 'find a course' do
      get("/api/v1/courses?search=#{name}")
      expect(JSON.parse(response.body)[0]['name']).to eq(name)
    end

    context 'when user is authorised' do
      let(:another_teacher) { create(:teacher) }
      let(:name) { Course.last.name }

      before { create_list(:course, 2, user: another_teacher) }

      it 'find courses attached to the teacher' do
        get('/api/v1/courses', headers:)
        expect(JSON.parse(response.body).length).to eq(2)
      end

      it 'find the course attached to the teacher' do
        get("/api/v1/courses?search=#{name}", headers:)
        expect(JSON.parse(response.body)[0]['name']).to eq(name)
      end

      it 'Find courses which the current user is attached to', skip: 'TDD for course search by students' do
        # TODO TDD for course search by students
      end
    end
  end
end
