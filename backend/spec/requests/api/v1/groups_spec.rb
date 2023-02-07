require 'rails_helper'

RSpec.describe 'Api::V1::Sessions' do
    describe  'post /api/v1/groups/new'
    let(:name) { 'SAWQ' }
    let(:params) { { name:, User.id: } }
    
    it "creates a group" do 
        post('/api/v1/groups/new', params:)
        expect(response).to have_http_status(:created)
        
        it "realy creates a group" do
            expect { result }.to change( Group.count ).from(0).to(1)
        end   
    end
end