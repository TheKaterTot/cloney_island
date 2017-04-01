require 'rails_helper'

feature "user changes password" do
  scenario "on their profile page" do
    user = Fabricate(:user)
    token = Fabricate(:password_token, token: '123',  user: user)

    login(user.name)

    visit user_path(user)

    expect_any_instance_of(PasswordsController).to receive(:send_token)
    within("#user-info-table") do
      click_on("Change Password")
    end

    expect(current_path).to eq(edit_password_path)

    fill_in "Token", with: "123"
    fill_in "New Password", with: "new_password"
    fill_in "Password Confirmation", with: "new_password"

    click_on "Save"

    expect(current_path).to eq(user_path(user))
    expect(user.reload.authenticate("new_password")).to be_truthy
  end
end

