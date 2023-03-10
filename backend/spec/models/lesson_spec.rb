# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Lesson do
  let(:lesson) { create(:lesson) }
  let(:user) { create(:user) }
  let(:course) { create(:course, user:) }

  describe 'validations' do
    it 'valid value' do
      expect(lesson).to be_valid
    end

    it 'not a valid title' do
      lesson.title = nil
      expect(lesson).not_to be_valid
    end

    it 'not a valid description' do
      lesson.description = nil
      expect(lesson).not_to be_valid
    end
  end

  describe 'associations' do
    it { is_expected.to belong_to(:course) }
  end
end
