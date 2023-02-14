# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Groups::Create do
  subject(:service) { described_class.new.call(**params) }

  let(:params) do
    { name: 'SAWQ' }
  end

  context 'when params are valid' do
    it 'creates new group' do
      expect { service }.to change(Group, :count).by(1)
    end

    it 'returns success result' do
      expect(service).to be_success
    end
  end

  context 'when params are invalid' do
    let(:params) { { name: '' } }

    it 'does not create new user' do
      expect { service }.not_to change(Group(:count))
    end

    it 'returns failure result' do
      expect(service).to be_failure
    end
  end
end
