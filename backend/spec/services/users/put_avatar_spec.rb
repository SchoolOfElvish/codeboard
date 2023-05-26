# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Users::PutAvatar do
  subject(:service) { described_class.new.call(current_user: user, signed_blob_id: signed_blob_id) }
  
  #eyJfcmFpbHMiOnsibWVzc2FnZSI6IkJBaHBEZz09IiwiZXhwIjpudWxsLCJwdXIiOiJibG9iX2lkIn19--71f70ca6b22dad5a9b03f71e86573b5cb2fa6815
  
  let(:signed_blob_id) { "eyJfcmFpbHMiOnsibWVzc2FnZSI6IkJBaHBEZz09IiwiZXhwIjpudWxsLCJwdXIiOiJibG9iX2lkIn19--71f70ca6b22dad5a9b03f71e86573b5cb2fa6815" }
  let(:user) { create(:user) }

  context 'when param valid' do
    it 'update user avatar' do
      binding.pry
      
      expect(service).to be_success
    end
  end
end