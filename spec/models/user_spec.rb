require 'rails_helper'

RSpec.describe User, type: :model do

  it "create users" do
    user1 = User.create({name:'Pasha', email:'test@mail.ru', password: 'testtest'})
    expect(user1).to be_persisted
  end

end
