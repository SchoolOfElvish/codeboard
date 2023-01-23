require 'rails_helper'

RSpec.describe User, type: :model do
  subject(:user1) {User.create({name:'Pasha', email:'test@mail.ru', password: 'testtest'})}
  
  it "create users" do
    expect(user1).to be_persisted
  end
end