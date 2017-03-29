require 'rails_helper'

feature 'when a guest visits the root page' do
  scenario 'they see login and questions in navbar' do
    visit root_path

    within('.nav-wrapper') do
      expect(page).to have_content('Login')
      expect(page).to have_content('Questions')
      expect(page).to have_content('Sign Up')
    end
  end

  scenario 'they can see recent questions and categories' do
    user            = Fabricate(:user)
    category        = Fabricate(:category)
    first_question  = Fabricate(:question, user:user, category:category)
    second_question = Fabricate(:question, user:user, category:category)

    visit '/'

save_and_open_page
    visit root_path
    within('.recent-activity') do
      expect(page).to have_content('Recent Activity')
      expect(page).to have_content('Why')
    end

    within('.categories') do
      expect(page).to have_content('Categories')
      expect(page).to have_content('food')
    end
  end
end
