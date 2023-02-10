# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Course do
  subject(:test_course) { described_class.create(course_params) }

  let(:current_user) { create(:user) }
  let(:name) { 'TestCourse' }
  let(:user_id) { current_user.id }
  let(:course_params) { { name:, user_id: } }

  it 'creates a course' do
    expect(test_course).to be_persisted
  end

  context 'when name is empty' do
    let(:name) { '' }

    it "dosen't create a new course" do
      expect(test_course).not_to be_persisted
    end
  end

  context 'when name is long' do
    let(:name) { 'q' * 256 }

    it 'create a new course' do
      expect(test_course).to be_persisted
    end
  end

  context 'when name is too long' do
    let(:name) { 'q' * 257 }

    it "dosen't create a new course" do
      expect(test_course).not_to be_persisted
    end
  end
end
