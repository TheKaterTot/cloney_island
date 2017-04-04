require 'rails_helper'

describe "banned_users API" do
  it "sends banned users" do
    user_1 = User.create(name: "Tom Riddle", email: 'lord@voldemort.com', phone: '1', password: 'riddle', reputation: -1000)
    user_2 = User.create(name: "Draco Malfoy", email: 'draco@malfoy.com', phone: '2', password: 'malfoy', reputation: -20)
    user_3 = User.create(name: "Bellatrix", email: 'bella@trix.com', phone: '2', password: 'bella', reputation: -100)
    user_4 = User.create(name: "Dolores Umbridge", email: 'dolores@umbridge.com', phone: '2', password: 'pureblood', reputation: -50)
    user_5 = User.create(name: "Scorpious Malfoy", email: 'scorpio@malfoy.com', phone: '2', password: 'malfoy', reputation: -10)
    user_6 = User.create(name: "Harry Potter", email: 'harry@thechosenone.com', phone: '7', password: 'chosen', reputation: 1000)

    user_1.roles.create(name: 'blocked_user')
    user_2.roles.create(name: 'blocked_user')
    user_3.roles.create(name: 'blocked_user')
    user_4.roles.create(name: 'blocked_user')
    user_5.roles.create(name: 'blocked_user')
    user_6.roles.create(name: 'registered_user')

    get '/api/v1/users/banned'

    expect(response).to be_success

    users       = JSON.parse(response.body)
    user        = users.first
    second_user = users.second
    last_user   = users.last

    expect(users.count).to eq(5)
    expect(users.count).to_not eq(6)

    expect(user).to have_key "name"
    expect(user).to have_key "email"
    expect(user).to have_key "reputation"
    expect(user).to have_key "status"

    expect(user["name"]).to eq("Tom Riddle")
    expect(user["email"]).to eq("lord@voldemort.com")
    expect(user["reputation"]).to eq(-1000)
    expect(user["status"]).to eq("blocked_user")


    expect(second_user["name"]).to eq("Draco Malfoy")
    expect(second_user["email"]).to eq("draco@malfoy.com")
    expect(second_user["reputation"]).to eq(-20)
    expect(second_user["reputation"]).to_not eq(8)
    expect(user["status"]).to eq("blocked_user")

    expect(last_user["name"]).to eq("Scorpious Malfoy")
    expect(last_user["email"]).to eq("scorpio@malfoy.com")
    expect(last_user["reputation"]).to eq(-10)
    expect(last_user["reputation"]).to_not eq(3)
    expect(user["status"]).to eq("blocked_user")

    expect(last_user["name"]).to_not eq("Harry Potter")
  end
end
