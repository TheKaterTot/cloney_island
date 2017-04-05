require 'rails_helper'

feature 'user visits root' do
  attr_reader :user
  before(:each) do
    @user = Fabricate(:user, password: 'password')
    @user.roles.create(name: 'registered_user')
  end
  scenario 'user logs in successfully' do

    visit '/'

    expect(page).to have_css('#welcome_jumbotron')

    within('#nav-mobile2') do
      click_link 'Login'
    end

    expect(current_path).to eq(login_path)

    fill_in "Name", with: "#{user.name}"
    fill_in "Password", with: "password"

    click_button "Login"
    expect(current_path).to eq(user_path(user))

    within('#nav-mobile2') do
      expect(page).to have_link("Logout")
      expect(page).to have_link("Profile")
    end

    expect(page).to_not have_css('#welcome_jumbotron')
  end

  scenario 'logged in user can navigate to profile' do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit '/'

    within('#nav-mobile2') do
      click_link 'Profile'
    end

    expect(current_path).to eq(user_path(user))
  end

  scenario 'logged in user can log out' do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit user_path(user)

    within('#nav-mobile2') do
      click_link 'Logout'
    end

    expect(current_path).to eq(root_path)
    within('.alert-success') do
      expect(page).to have_content("You've logged out.  Come back soon!")
    end
  end

  scenario 'user login fails' do

    visit '/'

    within('#nav-mobile2') do
      click_link 'Login'
    end
    expect(current_path).to eq(login_path)

    fill_in "Name", with: "#{user.name}"
    fill_in "Password", with: "bad_password"

    click_button "Login"
    expect(current_path).to eq(login_path)
    expect(page).to have_content("Invalid Credentials")
  end
end
