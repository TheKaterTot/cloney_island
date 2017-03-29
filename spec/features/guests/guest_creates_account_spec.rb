require 'rails_helper'

feature 'when a guest visits the root page' do
  scenario 'guest creates account' do
    visit root_path

    click_on "Sign Up"

    expect(current_path).to eq(new_user_path)

    fill_in "Name", with: "Smile Warbler"
    fill_in "Email", with: "smile@warbler.com"
    fill_in "Phone", with: "123-456-7890"
    fill_in "Password", with: "seekrit"
    fill_in "Password confirmation", with: "seekrit"

    expect { click_on "Create Account"}.to change(User, :count).by(1)
    byebug
  end
end
