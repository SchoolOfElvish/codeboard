# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Sessions::Refresher, type: :service do
  subject(:refresh) { described_class.new.call(token_params:) }

  let(:user) { create(:user) }
  let(:issuer) { Jwt::Issuer.call(user) }

  let(:token_params) do
    {
      token: issuer[0],
      refreshToken: issuer[1].token
    }
  end

  context 'when tokens are refreshed', skip: 'WIP' do
    it 'returns success' do
      expect(refresh).to be_success
    end

    it 'returns new access token' do
      expect(refresh.value![0]).to be_a String
    end

    it 'returns new refresh token' do
      expect(refresh.value![1]).to be_a String
    end
  end
end
