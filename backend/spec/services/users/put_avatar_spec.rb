# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Users::PutAvatar do
  subject(:service) { described_class.new.call(signed_blob_id, current_user) }

  before do
    puts ActiveStorage::Current.url_options.to_h.inspect
  end

  let(:signed_blob_id) do
    'eyJfcmFpbHMiOnsibWVzc2FnZSI6IkJBaHBEZz09IiwiZXhwIjpudWxsLCJwdXIiOiJibG9iX2lkIn19--573b5cb2fa6815'
  end

  let(:current_user) { create(:user) }

  context 'when signed_blob_id invalid' do
    it 'return failure blob not found' do
      expect(service).to be_failure
    end
  end

  context 'when signed_blob_id exist' do
    let(:file) { Rails.root.join('spec/fixtures/files/download.jpeg').open }

    let(:blob) { ActiveStorage::Blob.create_and_upload!(io: file, filename: 'file.png') }
    let(:signed_blob_id) { blob.signed_id }

    it 'return sucess' do
      expect(service).to be_success
    end
  end
end
