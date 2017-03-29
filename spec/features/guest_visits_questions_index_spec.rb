require 'rails_helper'

describe 'when a guest visits the questions page' do
  it 'it should see a list of questions' do
    user            = Fabricate(:user)
    category        = Fabricate(:category)
    first_question  = Fabricate(:question, user:user, category:category)
    second_question = Fabricate(:question, user:user, category:category)

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
end
