require 'rails_helper'

RSpec.describe Group, type: :model do
  subject(:group1) { Group.create({name: "SAWQ", user_id: "1" })}
  before { subject(:user) {User.create({ name: 'Pasha', email: 'test@mail.ru', password: 'testtest' })} }

  it "create group" do 
    expect(group1).to be_persisted
  end
end
