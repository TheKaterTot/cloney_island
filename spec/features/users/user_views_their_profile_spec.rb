require 'rails_helper'

feature 'user profile' do
  scenario 'user sees their account information' do
    user = Fabricate(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit user_path(user)

    expect(page).to have_css('#user-info')

    within('#user-info-table') do
      expect(page).to have_content(user.name)
      expect(page).to have_content(user.email)
      expect(page).to have_content(user.phone)
      expect(page).to have_content('Reputation')
    end
  end

  scenario 'user sees their avatar image' do
    user = Fabricate(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit user_path(user)

    expect(page).to have_css('#user-avatar')

  end
end
