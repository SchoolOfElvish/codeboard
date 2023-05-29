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
    let(:course) { create(:course) }
    let(:name) { course.name }
    let(:user) { create(:teacher) }
    let(:params) { { name: } }
    let(:headers) { auth_header_for(user) }

    it 'find a course' do
      get("/api/v1/courses?search=#{name}", headers:)
      expect(JSON.parse(response.body)[0]['name']).to eq(name)
    end

    it 'find a course attached to current user', skip: "I'll write it later" do
      # TODO This spec should be checking if search return correct results for current user
    end
  end
end
