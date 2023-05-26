# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Users::CreateBlob do
  subject(:service) { described_class.new.call(**params) }
  
  let(:params) do
    {
      filename: 'download.jpeg',
      byte_size: 9766,
      checksum: 'ZR0N6Qha6ejk5H3X5nG4gg==',
      content_type: 'image/jpeg'
    }
  end

  context 'when params valid' do 
    it 'create new blob' do
      assert service.success?
    end
  end
end