require "rails_helper"

feature "user edits profile info" do
  def login(username)
    visit login_path

    fill_in "Name", with: username
    fill_in "Password", with: "password"

    click_button "Login"
  end

  scenario "they visit their own profile" do
    user = Fabricate(:user)

    login(user.name)

    visit user_path(user)

    within("#user-info-table") do
      click_on "Edit User Profile"
    end

    expect(current_path).to eq(edit_user_path(user))

    fill_in "Email", with: "no@no.com"
    fill_in "Phone", with: "123-456-7890"

    click_on("Save")

    expect(current_path).to eq(user_path(user))

    within("#user-info-table") do
      expect(page).to have_content("no@no.com")
      expect(page).to have_content("123-456-7890")
    end
  end

  scenario "they leave a field blank" do
    user = Fabricate(:user)

    login(user.name)

    visit user_path(user)

    within("#user-info-table") do
      click_on "Edit User Profile"
    end

    expect(current_path).to eq(edit_user_path(user))

    fill_in "Email", with: "no@no.com"
    fill_in "Phone", with: ""

    click_on("Save")

    within(".error") do
      expect(page).to have_content("Phone can't be blank")
    end
  end
end
