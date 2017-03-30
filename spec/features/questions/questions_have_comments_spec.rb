require 'rails_helper'

feature 'user views a question' do
  scenario 'question has comments' do
    question = Fabricate(:question)
    user = Fabricate(:user)
    comment = question.comments.create!(body: "Answer comment!",
                                         user_id: user.id)
    comment2 = question.comments.create!(body: "Another comment!",
                                         user_id: user.id)

    visit question_path(question)

    expect(page).to have_css('#question_comments')

    within('#question_comments') do
      expect(page).to have_content(comment.body)
      expect(page).to have_content(comment2.body)
    end

  end
  scenario 'question has no comments' do
    question = Fabricate(:question)

    visit question_path(question)

    expect(page).to_not have_css('#question_comments')

  end
end
