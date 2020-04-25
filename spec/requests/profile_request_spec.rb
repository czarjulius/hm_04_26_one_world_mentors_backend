require 'rails_helper'

describe 'User', type: :request do
  it 'returns my profile' do
    data = FactoryBot.create(:user)
    user_without_id = JSON.parse(data.to_json).except("id")
    User.new(user_without_id).save
    get '/profile', params: { email: user_without_id["email"] }

    expected = JSON.parse(response.body)
    expect(response).to have_http_status(:success)
    expect(expected['profile']['first_name']).to eq(data[:first_name])
    expect(expected['profile']['last_name']).to eq(data[:last_name])
    expect(expected['profile']['email']).to eq(data[:email])
  end

  it 'returns null for no profile' do
    get '/profile', params: { email: "emma@1s" }
    expected = JSON.parse(response.body)
    expect(response).to have_http_status(:success)
    expect(expected['profile']).to eq(nil)
  end
end