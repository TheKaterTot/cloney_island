require 'rails_helper'

describe "user API" do
  it "sends a single user" do
    user = Fabricate(:user, id:1, name:"Jabrony", email: "Jabron@jabron.com", phone:"333-333-3333",reputation:3)

    get '/api/v1/users/1'

    expect(response).to be_success

    user = JSON.parse(response.body)

    expect(user).to have_key "name"
    expect(user).to have_key "email"
    expect(user).to have_key "reputation"

    expect(user["name"]).to eq("Jabrony")
    expect(user["email"]).to eq("Jabron@jabron.com")
    expect(user["reputation"]).to eq(3)
    expect(user["reputation"]).to_not eq(2)
  end
end
