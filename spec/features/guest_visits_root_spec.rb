require 'rails_helper'

feature 'when a guest visits the root page' do
  scenario 'they see login in navbar' do
    visit root_path

    within('.nav-wrapper') do
      expect(page).to have_content('Login')
    end
  end

  xscenario 'they can see recent questions and categories' do
    user            = Fabricate(:user)
    category        = Fabricate(:category)
    first_question  = Fabricate(:question, user:user, category:category)
    second_question = Fabricate(:question, user:user, category:category)

    visit root_path
    within('.body') do
      expect(page).to have_content('Recent Questions')
      expect(page).to have_content('This is my question')
    end

    within('.categories') do
      expect(page).to have_content('Categories')
      expect(page).to have_content('Ruby')
    end
  end
end
