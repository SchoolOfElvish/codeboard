# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User do
  subject(:user) { described_class.create(user_params) }

  let(:user_params) { { last_name:, first_name:, email:, password:, password_confirmation:, role: } }
  let(:last_name) { 'Lastname' }
  let(:first_name) { 'Firstname' }
  let(:email) { 'test@mail.ru' }
  let(:password) { 'testtest' }
  let(:password_confirmation) { 'testtest' }
  let(:role) { 'student' }

  it 'create users' do
    expect(user).to be_persisted
  end

  context "when last_name doesn't exist" do
    let(:user_params) { { first_name:, email:, password:, password_confirmation:, role: } }

    it "doesn't create user" do
      expect(user).not_to be_persisted
    end
  end

  context "when furst_name doesn't exist" do
    let(:user_params) { { last_name:, email:, password:, password_confirmation:, role: } }

    it "doesn't create user" do
      expect(user).not_to be_persisted
    end
  end

  context "when email doesn't exist" do
    let(:user_params) { { last_name:, first_name:, password:, password_confirmation:, role: } }

    it "doesn't create user" do
      expect(user).not_to be_persisted
    end
  end

  context "when password doesn't exist" do
    let(:user_params) { { last_name:, first_name:, email:, password_confirmation:, role: } }

    it "doesn't create user" do
      expect(user).not_to be_persisted
    end
  end

  context "when password_confirmation doesn't exist" do
    let(:user_params) { { last_name:, first_name:, email:, password:, role: } }

    it "doesn't create user" do
      expect(user).not_to be_persisted
    end
  end

  context "when role doesn't exist" do
    let(:user_params) { { last_name:, first_name:, email:, password:, password_confirmation: } }

    it "doesn't create user" do
      expect(user).not_to be_persisted
    end
  end

  context "when password and password_confirmation doesn't not match" do
    let(:password_confirmation) { 'tsettset' }

    it "doesn't create user" do
      expect(user).not_to be_persisted
    end
  end
end
