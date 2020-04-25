require "rails_helper"
require "json"

RSpec.describe "Auths", type: :request do
  user = nil
  before do
    user = User.create(first_name: "Julius", last_name: "Ngwu", email: "julius@gmail.com", password: "julius@1", user_type: "mentee")
  end

  describe "POST /auth" do
    it "should authenticate and return a user if cedentials are valid" do
      expect(JsonWebToken).to receive(:encode).and_return("token")
      data = { "email" => "julius@gmail.com", "password" => "julius@1" }

      post "/login", params: data

      user_info = JSON.parse(response.body)

      expect(user_info["email"]).to eq("julius@gmail.com")
      expect(user_info["token"]).to eq("token")
    end

    it "should authenticate and return an error message if cedentials are invalid" do
      data = { "email" => "joy@gmail.com", "password" => "11111" }
      post "/login", params: data
      user_info = JSON.parse(response.body)
      expect(user_info["error"]).to eq("Invalid email or password")
    end
  end
end
