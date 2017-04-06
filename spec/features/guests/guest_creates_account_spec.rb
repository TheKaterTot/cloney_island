require 'rails_helper'

feature 'when a guest visits the root page' do
  scenario 'guest creates account' do
    Role.create(id:1, name:"registered_user")
    visit root_path

    click_on "Create Account"

    expect(current_path).to eq(new_user_path)

    fill_in "Name", with: "Smile Warbler"
    fill_in "Email", with: "smile@warbler.com"
    fill_in "Phone", with: "123-456-7890"
    fill_in "Password", with: "seekrit"
    fill_in "Password confirmation", with: "seekrit"

    expect { click_on "Create Account"}.to change(User, :count).by(1)

    user = User.last

    expect(user.name).to eq("Smile Warbler")
    expect(user.email).to eq("smile@warbler.com")
    expect(user.phone).to eq("123-456-7890")
  end

  scenario 'guest is on the login page and clicks on create account' do
    visit login_path

    within("#account_create_button") do
        click_on "Create An Account"
    end

    expect(current_path).to eq(new_user_path)
  end
end
