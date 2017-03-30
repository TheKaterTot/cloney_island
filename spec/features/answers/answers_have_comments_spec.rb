require 'rails_helper'

feature 'user views a question' do
  scenario 'answers have comments' do
    question = Fabricate(:question)
    user     = Fabricate(:user)
    answer   = Fabricate(:answer, question:question, user:user)
    comment1 = answer.comments.create!(body: "Answer comment!",
                                      user_id: user.id)
    comment2 = answer.comments.create!(body: "Another comment!",
                                       user_id: user.id)

    visit question_path(question)

    expect(page).to have_css('#answer_comments')

    within all('#answer_comments').first do
      expect(page).to have_content(comment1.body)
      expect(page).to have_content(comment2.body)
    end
  end
  
  scenario 'answer has no comments' do
    question = Fabricate(:question)
    user     = Fabricate(:user)
    answer   = Fabricate(:answer, question:question, user:user)

    visit question_path(question)

    expect(page).to_not have_css('#answer_comments')

  end
end
