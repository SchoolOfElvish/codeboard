# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Group do
  subject(:group1) { described_class.create(group_params) }

  let(:current_user) { create(:user) }
  let(:name) { 'SAWQ' }
  let(:author_id) { current_user.id }
  let(:group_params) { { name:, author_id: } }

  it 'creates a group' do
    expect(group1).to be_persisted
  end

  it 'increments amount of records in the DB by 1' do
    expect { group1 }.to change(described_class, :count).by(1)
  end

  context 'when name is empty' do
    let(:name) { '' }

    it "dosen't create a group" do
      expect(group1).not_to be_persisted
    end
  end

  context 'when name is < 4' do
    let(:name) { 'SAQ' }

    it "dosen't create a group" do
      expect(group1).not_to be_persisted
    end
  end
end
