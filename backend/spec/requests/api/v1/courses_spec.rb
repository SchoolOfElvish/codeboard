# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::Courses' do
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
    end
  end
end
