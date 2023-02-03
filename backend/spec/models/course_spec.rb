# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Course, type: :model do
  subject(:testCourse) { described_class.create(course_params) }

  let(:current_user) { User.create({ name: 'Test', email: 'test@mail.ru', password: 'testtest' }) }
  let(:name) { 'TestCourse' }
  let(:user_id) { current_user.id }
  let(:course_params) { { name:, user_id:} }

  it 'creates a course attached to current user' do
    expect(testCourse).to be_persisted
    expect(testCourse.user_id).to eq(current_user.id)
  end

  context 'name is empty' do
    let(:name) { '' }

    it "dosen't create a new course" do
      expect(testCourse).to_not be_persisted
    end
  end
end
