# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User do
  subject(:user1) { described_class.create({ name: 'Pasha', email: 'test@mail.ru', password: 'testtest' }) }

  it 'create users' do
    expect(user1).to be_persisted
  end
end
