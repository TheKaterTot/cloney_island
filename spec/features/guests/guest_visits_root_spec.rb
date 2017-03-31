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

  scenario 'they can sort questions shown by cateogry' do
    user            = Fabricate(:user)
    category        = Fabricate(:category, name:"Software")
    category_two    = Fabricate(:category, name:"Physics")
    category_three  = Fabricate(:category, name:"Self-Help")
    first_question  = Fabricate(:question, title:"What is?", user:user, category:category)
    second_question = Fabricate(:question, title:"How come?",user:user, category:category_two)
    second_question = Fabricate(:question, title:"Who's there?",user:user, category:category_three)

    visit root_path

    within('.root-questions') do
      expect(page).to have_content("What is?")
      expect(page).to have_content("How come?")
      expect(page).to have_content("Who's there?")

      expect(page).to_not have_content("Why not?")
    end

    within('.categories') do
      expect(page).to have_content("Software")
      expect(page).to have_content("Physics")
      expect(page).to have_content("Self-Help")

      expect(page).to_not have_content("Gardening")

      click_on("Software")
    end

    expect(current_path).to eq(root_path)

    within('.root-questions') do
      expect(page).to have_content("What is?")

      expect(page).to_not have_content("How Come?")
      expect(page).to_not have_content("Who's there?")
      expect(page).to_not have_content("Gardening")
    end
  end
end
