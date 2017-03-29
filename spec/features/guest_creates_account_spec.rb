require 'rails_helper'

feature 'when a guest visits the root page' do
  scenario 'they see login in navbar' do
    visit root_path

    within('.nav-wrapper') do
      expect(page).to have_content('Login')
    end
  end
end