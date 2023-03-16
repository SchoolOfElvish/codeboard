# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Users::UpdateUserInfo do
  subject(:update_user_info) { described_class.new.call(user:, user_params:) }

  let(:user) { create(:user) }
  let(:user_params) do
    {
      first_name: user.first_name,
      last_name: user.last_name,
      birthdate: nil
    }
  end
  let(:random_date) do
    Time.zone.today - rand(50_000)
  end

  context 'when user does not have birthdate' do
    it 'returns Success result' do
      expect(update_user_info).to be_success
    end

    it 'does not update user birthdate' do
      update_user_info
      expect(user.birthdate).to be_nil
    end
  end

  context 'when user has birthdate' do
    let(:user_params) do
      {
        first_name: user.first_name,
        last_name: user.last_name,
        birthdate: random_date
      }
    end

    it 'user update exist birthdate' do
      update_user_info
      expect(user.birthdate).to eq(random_date)
    end

    it 'returns Success result' do
      expect(update_user_info).to be_success
    end
  end

  context 'when user update first name on valid' do
    let(:user_params) do
      {
        first_name: 'Newname',
        last_name: user.last_name,
        birthdate: nil
      }
    end

    it 'returns Success result' do
      expect(update_user_info).to be_success
    end

    it 'updates user first name' do
      update_user_info
      expect(user.first_name).to eq('Newname')
    end
  end

  context 'when user update last name on valid' do
    let(:user_params) do
      {
        first_name: user.first_name,
        last_name: 'Newlastname',
        birthdate: nil
      }
    end

    it 'returns Success result' do
      expect(update_user_info).to be_success
    end

    it 'updates user last name' do
      update_user_info
      expect(user.last_name).to eq('Newlastname')
    end
  end

  context 'when user provide nil full name' do
    let(:user_params) do
      {
        first_name: nil,
        last_name: nil,
        birthdate: nil
      }
    end

    it 'returns error' do
      expect(update_user_info).to be_failure
    end
  end
end
