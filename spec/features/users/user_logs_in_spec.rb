require 'rails_helper'

feature 'user visits root' do
  scenario 'user logs in' do
    user = Fabricate(:user, password: 'password')

    visit '/'

    click_link 'Login'

    expect(current_path).to eq(login_path)

    fill_in "Name", with: "#{user.name}"
    fill_in "Password", with: "password"

    click_button "Login"
    expect(current_path).to eq(user_path(user))
  end
end
