# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User do
  subject(:user1) { described_class.create({ last_name: 'test', first_name: 'Pasha', email: 'test@mail.ru', 
                                            password: 'testtest', password_confirmation: 'testtest', role: 'student' }) }

  it 'create users' do
    expect(user1).to be_persisted
  end
end
