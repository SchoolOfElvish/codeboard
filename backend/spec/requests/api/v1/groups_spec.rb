require 'rails_helper'

RSpec.describe 'Api::V1::Groups' do
    describe  'post /create'
    let(:user) { create(:user) }
    let(:name) { 'SAWQ' }
    let(:params) { { name: } }
    let(:headers) { auth_header_for(user) }
    
    it "creates a group" do 
        post('/api/v1/groups', params:, headers:)
        expect(response).to have_http_status(:created)
    end
    
    context 'when name is empty' do
        let(:name) { '' }
  
        it "dosen't create a new group" do
          post('/api/v1/groups', params:, headers:)
          expect(response).to have_http_status(:unprocessable_entity)
        end
    end

    context 'when name < 4 symbols' do
        let(:name) { 'SAW' }
  
        it "dosen't create a new group" do
          post('/api/v1/groups', params:, headers:)
          expect(response).to have_http_status(:unprocessable_entity)
        end
    end

    context 'when name is over 20 symbols' do
        let(:name) { 'SAWQFSAWQFSAWQFSAWQFS' }
  
        it "dosen't create a new group" do
          post('/api/v1/groups', params:, headers:)
          expect(response).to have_http_status(:unprocessable_entity)
        end
    end
end