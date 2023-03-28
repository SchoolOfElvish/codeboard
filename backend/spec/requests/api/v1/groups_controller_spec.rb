# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::GroupsController' do
  let(:user) { create(:user) }
  let(:name) { 'Sawq' }
  let(:author_id) { user.id }
  let(:params) { { name:, author_id: } }
  let(:headers) { auth_header_for(user) }

  it 'creates a group' do
    post('/api/v1/groups', params:, headers:)
    expect(response).to have_http_status(:created)
  end

  context 'when name is empty' do
    let(:name) { '' }

    it "dosen't create a new group" do
      post('/api/v1/groups', params:, headers:)
      expect(response).to have_http_status(:unprocessable_entity)
    end

    it 'return an error' do
      post('/api/v1/groups', params:, headers:)
      expect(JSON.parse(response.body)['errors']).to match({ 'name' => ['is too short (minimum is 4 characters)'] })
    end
  end

  context 'when name < 4 symbols' do
    let(:name) { 'SAW' }

    it "dosen't create a new group" do
      post('/api/v1/groups', params:, headers:)
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end
end
