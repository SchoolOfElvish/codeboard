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
        expect(JSON.parse(response.body)['errors']).to match(["\"Name\" can't be blank"])
      end
    end
  end

  describe 'GET /all' do
    let(:course) { create(:course) }
    let(:name) { course.name }

    before { create_list(:course, 3) }

    it 'show all courses' do
      get('/api/v1/courses/all')
      expect(JSON.parse(response.body).length).to eq(3)
    end

    it 'find a course' do
      get("/api/v1/courses/all?search=#{name}")
      expect(JSON.parse(response.body)[0]['name']).to eq(name)
    end
  end

  describe 'GET /index' do
    let(:teacher) { create(:teacher) }
    let(:student) { create(:user) }
    let!(:course) { create(:course, user: teacher) }
    let(:name) { course.name }
    let(:headers) { auth_header_for(teacher) }
    let(:another_teacher) { create(:teacher) }

    before { create_list(:course, 2, user: another_teacher, name: course.name) }

    it 'find courses attached to the teacher' do
      get('/api/v1/courses', headers:)
      expect(JSON.parse(response.body).length).to eq(1)
    end

    it 'find the course attached to the teacher' do
      get("/api/v1/courses?search=#{name}", headers:)
      expect(JSON.parse(response.body).length).to eq(1)
    end

    it 'Find courses which the current user is attached to', skip: 'TDD for course search by students' do
      # TODO: TDD for course search by students
    end
  end

  describe 'GET /show' do
    let(:teacher) { create(:teacher) }
    let(:course) { create(:course, user: teacher) }
    let(:id) { course.id }
    let(:name) { course.name }
    let(:headers) { auth_header_for(teacher) }

    it 'return the course' do
      get("/api/v1/courses/#{id}", headers:)
      expect(JSON.parse(response.body)['name']).to eq(name)
    end

    context 'when id does not exist' do
      let(:course) { create(:course, id: 1) }
      let(:id) { 2 }

      it "dosen't return a course" do
        get("/api/v1/courses/#{id}", headers:)
        expect(JSON.parse(response.body)['errors']).to eq("Couldn't find Course with 'id'=#{id}")
      end
    end
  end
end
