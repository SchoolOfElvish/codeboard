# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Users::SignIn do
  subject(:sign_in) { described_class.new.call(email:, password:) }

  let(:user) { create(:user) }
  let(:email) { user.email }
  let(:password) { user.password }

  context 'when password and email are valid' do
    it 'return Sucess result' do
      expect(sign_in).to be_success
    end
  end

  context 'when email is not valid' do
    let(:email) { user.email.chop }

    it 'return Failure(User not found)' do
      expect(sign_in).to be_failure
    end
  end

  context 'when password is not valid' do
    let(:password) { user.password.chop }

    it 'return Failure(Wrong password)' do
      expect(sign_in).to be_failure
    end
  end
end
