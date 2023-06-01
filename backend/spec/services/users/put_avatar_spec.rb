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
    before { upload }

    let(:signed_blob_id) { create_blob.signed_id }

    it 'return sucess' do
      expect(service).to be_success
    end
  end

  # rubocop:disable Metrics/MethodLength

  def create_blob
    avatar_params = {
      filename: 'download.jpeg',
      byte_size: 9766,
      checksum: 'ZR0N6Qha6ejk5H3X5nG4gg==',
      content_type: 'image/jpeg'
    }
    result = Users::CreateBlob.new.call(avatar_params)

    case result
    in Dry::Monads::Result::Success(blob)
      @blob ||= blob
    end
  end

  # rubocop:enable Metrics/MethodLength

  def upload
    blob = create_blob
    file = fixture_file_upload('download.jpeg', 'image/jpeg')
    blob.upload(file)
  end
end
