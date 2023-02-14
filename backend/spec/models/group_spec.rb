require 'rails_helper'

RSpec.describe Group, type: :model do
  subject(:group1) { Group.create(group_params)}

  let(:current_user) { create(:user) }
  let(:name) { "SAWQ" }
  let(:user_id) { current_user.id }
  let(:group_params) { { name:, user_id: } }

  it 'creates a group' do
    expect(group1).to be_persisted
  end

  it 'realy creates a group' do
    expect { group1 }.to change { Group.count }.by(1)
  end  

  context 'name is empty' do
    let(:name) { '' }

    it "dosen't create a group" do
      expect(group1).not_to be_persisted
    end
  end

  context 'name is < 4' do
    let(:name) { 'SAQ' }

    it "dosen't create a group" do
      expect(group1).not_to be_persisted
    end
  end

  context 'OVER 20 symbols' do
    let(:name) { 'SAWQFSAWQFSAWQFSAWQFf' }

    it "dosen't create a group" do
      expect(group1).not_to be_persisted
    end
  end

end
