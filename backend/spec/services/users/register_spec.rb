# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Users::Register do
  subject(:service) { described_class.new.call(**params) }

  let(:params) do
    { email: 'test@gmail.com', password: 'qwerty123', passwordConfirmation: 'qwerty123', firstName: 'testfirst',
      lastName: 'testlast', role: 'STUDENT' }
  end

  context 'when params are valid' do
    it 'creates new user' do
      expect { service }.to change(User, :count).by(1)
    end

    it 'returns success result' do
      expect(service).to be_success
    end

    it 'creates token' do
      expect(service.value![0]).to be_a(String)
    end

    it 'creates refresh token' do
      expect(service.value![1]).to be_a(String)
    end
  end

  context 'when params are invalid' do
    let(:params) do
      { email: '', password: '', password_confirmation: '', first_name: 'testfirst',
        last_name: 'testlast', role: 'STUDENT' }
    end

    it 'does not create new user' do
      expect { service }.not_to change(User, :count)
    end

    it 'returns failure result' do
      expect(service).to be_failure
    end
  end

  context 'when password confirmation not passed', skip: 'Write custom check later' do
    let(:params) do
      { email: 'test@gmail.com', password: 'qwerty123', firstName: 'testfirst',
        lastName: 'testlast', role: 'STUDENT' }
    end

    it 'does not create new user' do
      expect { service }.not_to change(User, :count)
    end

    it 'returns failure result' do
      expect(service).to be_failure
    end
  end
end
