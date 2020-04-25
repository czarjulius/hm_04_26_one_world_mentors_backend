require 'rails_helper'

RSpec.describe User, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  user  =nil
  before do
    user= User.create(first_name: 'Julius', last_name: 'Ngwu', email:'julius@gmail.com',password:'julius@1', user_type:'mentee')
  end
  it 'is valid when all attributes are provided' do
    expect(user).to be_valid
  end
  it"The authenticate method should return  valid user if credentials are valid" do
  auth_user=User.authenticate(user["email"],user["password"]) 
  expect(auth_user["email"]).to eq(user["email"])
end
it"The authenticate method should returna nil if credentials are not valid" do
  auth_user=User.authenticate("joy123","williams") 
  expect(auth_user).to eq(nil)
end
end
