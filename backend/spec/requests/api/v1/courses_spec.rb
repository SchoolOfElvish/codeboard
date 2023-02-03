# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::Courses', type: :request do
  describe 'POST /create' do
    before do
      sign_in user
      # login_user
    end

    let(:user) { create(:user) }
    let(:name) { 'TestCourse' }
    let(:params) { { name: } }

    it 'create a new courese' do
      post('/api/v1/courses', params:)
      expect(response).to have_http_status(:created)
    end
  end
end

# require 'rails_helper'

# RSpec.describe 'Api::V1::Courses', type: :request do
#   describe "POST /new" do
#     it "returns http success" do
#       post '/api/v1/courses/new'
#       expect(response).to have_http_status(:success)
#     end
#   end

# end 