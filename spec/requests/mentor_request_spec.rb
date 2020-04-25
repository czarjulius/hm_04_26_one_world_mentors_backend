require "rails_helper"

RSpec.describe "Users", type: :request do
  headers = nil
  before do
    data = { "email" => "julius@gmail.com", "password" => "julius@1" }
    user = User.create(first_name: "Julius", last_name: "Ngwu", email: "julius@gmail.com", password: "julius@1", user_type: "mentee")
    post "/login", params: data
    user_info = JSON.parse(response.body)
    headers = { "Authorization" => "Bearer " + user_info["token"] }
  end

  describe "GET /mentors" do
    it "should return error message if token is not present" do
      get "/mentors", headers: {}
      body = JSON.parse(response.body)
      expect(response).to have_http_status(401)
      expect(body["error"]).to eq("Missing token or Not Authorized")
    end
    it "returns empty list of mentors" do
      get "/mentors", headers: headers
      expect(response).to have_http_status(:success)
    end

    it "returns a single mentor in a list" do
      user = User.create(first_name: "mike", last_name: "tyson", email: "rm@mail.com", password: "yes", user_type: "mentor")
      get "/mentors", headers: headers
      expect(response.body).to include("mike")
      mentors = JSON.parse(response.body)
      expect(mentors["mentors"].first["first_name"]).to eq("mike")
      expect(mentors["mentors"].first["last_name"]).to eq("tyson")
      expect(mentors["mentors"].first["email"]).to eq("rm@mail.com")
      expect(mentors["mentors"].first["password"]).to eq("yes")
      expect(mentors["mentors"].first["user_type"]).to eq("mentor")
    end
  end
end
