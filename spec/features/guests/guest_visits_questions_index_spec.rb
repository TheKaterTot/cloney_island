require 'rails_helper'

describe 'when a guest visits the questions page' do
  attr_reader :user,
              :category,
              :first_question,
              :second_question,
              :category
  before(:each) do
    @user            = Fabricate(:user)
    @category        = Fabricate(:category)
    @first_question  = Fabricate(:question, user:user, category:category)
    @second_question = Fabricate(:question, user:user, category:category, title:"Bohagon")
  end

  it 'it should see a list of questions' do
    visit questions_path

    within(".questions_header") do
      expect(page).to have_content("All Questions")
    end

    within(".striped") do
      expect(page).to have_content(first_question.title)
      expect(page).to have_content(first_question.find_user)
      expect(page).to have_content(second_question.title)
      expect(page).to have_content(second_question.find_user)
    end
  end

  it 'should have a list of categories' do
    category_two    = Fabricate(:category, name:"Halumi")

    visit questions_path

    within ('.categories') do
      expect(page).to have_link(category.name)
      expect(page).to have_link(category_two.name)

      expect(page).to_not have_link("Fordham")
    end
  end

  it 'should sort questions by category' do
    second_user     = Fabricate(:user, name:"Quade")
    category_two    = Fabricate(:category, name:"Halumi")
    third_question  = Fabricate(:question, user:second_user, category:category_two, title:"Rust Buckets?")

    visit questions_path

    within ('.categories') do
      click_link(category.name)
    end

    expect(current_path).to eq(questions_path)

    within('.questions-by-category') do
      expect(page).to have_content(first_question.title)
      expect(page).to have_content(first_question.find_user)
      expect(page).to have_content(second_question.title)
      expect(page).to have_content(second_question.find_user)

      expect(page).to_not have_content(third_question.title)
      expect(page).to_not have_content(third_question.find_user)
    end
  end
end
