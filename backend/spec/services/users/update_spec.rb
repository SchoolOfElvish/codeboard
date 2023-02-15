# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Users::Update do
  subject(:add_birthdate) { described_class.new.call(user:, birthdate:) }

  let(:user) { create(:user) }
  let(:birthdate) { nil }
  let(:random_date) do
    Time.zone.today - rand(50_000)
  end

  context 'when user does not have birthdate' do
    it 'returns Success result' do
      expect(add_birthdate).to be_success
    end

    it 'does not update user birthdate' do
      add_birthdate
      expect(user.birthdate).to be_nil
    end
  end

  context 'when user has birthdate' do
    let(:birthdate) { random_date }

    it 'user update exist birthdate' do
      add_birthdate
      expect(user.birthdate).to eq(random_date)
    end

    it 'returns Success result' do
      expect(add_birthdate).to be_success
    end
  end
end
