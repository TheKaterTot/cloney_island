require 'rails_helper'

feature 'user can delete an answer' do
  scenario 'user owns an answer and clicks "Delete Answer"' do
    user = Fabricate(:user, id: 1, name: "we_the_best")
    user.roles.create(name: 'registered_user')

    question = Fabricate(:question,
                                      title: "Why are we the best?",
                                      body: "They're trying to stop us.",
                                      user: user)

    answer = question.answers.create(body: "BlessUp", user: user)
    answer_comment = answer.comments.create(body: "DJKhaled", user: user)
    question_comment = question.comments.create(body: "Gratitude", user: user)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit question_path(question)

    within(".question-answers") do
      expect(page).to have_content("BlessUp")
    end

    first('#answer-delete-button').click_button('Delete Answer')

    expect(current_path).to eq(question_path(question))

    expect(page).to_not have_css('#answer-delete-button')
    expect(question.answers.count).to eq(0)
    expect(Comment.count).to eq(1)
    expect(Comment.first.commentable_type).to eq('Question')
  end
    scenario 'user does not own an answer and cannot see "Delete Answer"' do
    user_1 = Fabricate(:user, id: 1, name: "we_the_best")
    user_1.roles.create(name: 'registered_user')

    user_2 = Fabricate(:user, id: 2, name: "we_the_best")
    user_2.roles.create(name: 'registered_user')

    question = Fabricate(:question,
                                      title: "Why are we the best?",
                                      body: "They're trying to stop us.",
                                      user: user_1)

    answer = question.answers.create(body: "BlessUp", user: user_1)
    answer_comment = answer.comments.create(body: "DJKhaled", user: user_1)
    question_comment = question.comments.create(body: "Gratitude", user: user_1)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user_2)

    visit question_path(question)
    expect(current_path).to eq(question_path(question))

    within(".question-answers") do
      expect(page).to have_content("BlessUp")
    end

    expect(page).to_not have_content('Delete Answer')
    expect(question.answers.count).to eq(1)
  end
end
