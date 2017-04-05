require 'rails_helper'

describe "by_reputation API" do
  it "sends a top 10 users by reputation" do
    Fabricate(:user, name:"Jabrony", email: "Jabron@jabron.com", phone:"333-333-3333",reputation:10)
    Fabricate(:user, name:"Jimjam", email: "Jimjam@jabron.com", phone:"444-444-4444",reputation:9)
    Fabricate(:user, name:"Jablewit", email: "Jablewit@jabron.com", phone:"555-555-5555",reputation:8)
    Fabricate(:user, name:"Jabangles", email: "Jabangles@jabron.com", phone:"666-666-6666",reputation:7)
    10.times do
      Fabricate(:user, name:"Gobledigook", email: "Hambone@alabaster.io", phone:"111-111-1111",reputation:1)
    end

    get '/api/v1/users/by_reputation'

    expect(response).to be_success

    users       = JSON.parse(response.body)
    user        = users.first
    second_user = users.second
    last_user   = users.last

    expect(users.count).to eq(10)

    expect(user).to have_key "name"
    expect(user).to have_key "email"
    expect(user).to have_key "reputation"

    expect(user["name"]).to eq("Jabrony")
    expect(user["email"]).to eq("Jabron@jabron.com")
    expect(user["reputation"]).to eq(10)
    expect(user["reputation"]).to_not eq(2)

    expect(second_user["name"]).to eq("Jimjam")
    expect(second_user["email"]).to eq("Jimjam@jabron.com")
    expect(second_user["reputation"]).to eq(9)
    expect(second_user["reputation"]).to_not eq(8)

    expect(last_user["name"]).to eq("Gobledigook")
    expect(last_user["email"]).to eq("Hambone@alabaster.io")
    expect(last_user["reputation"]).to eq(1)
    expect(last_user["reputation"]).to_not eq(3)
  end
end
