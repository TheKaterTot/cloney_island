require "rails_helper"

describe 'when a user visits a question show page' do
  it 'they can delete question comments owned by them' do
    user = Fabricate(:user, id: 1)
    question = Fabricate(:question, user: user)
    comment = question.comments.create!(body: "Nice comment", user_id: user.id)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit question_path(question)

    expect(page).to have_content(comment.body)

    within('#question-comments') do
      click_on 'Delete Comment'
    end

    expect(page).to_not have_content("Nice comment")
  end

  it 'they can delete answer comments owned by them' do
    user = Fabricate(:user, id: 1)
    question = Fabricate(:question, user: user)
    answer = Fabricate(:answer, user: user, question: question)
    comment = answer.comments.create!(body: "Nice answer comment", user_id: user.id)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit question_path(question)

    expect(page).to have_content("Nice answer comment")

    within('#answer-comments') do
      click_on "Delete Comment"
    end
    expect(answer.comments.count).to eq(0)
    expect(page).to_not have_content("Nice answer comment")
  end

  it 'non owner cannot delete comment' do
    user1 = Fabricate(:user, id: 1)
    user2 = Fabricate(:user, id: 2)
    question = Fabricate(:question, user: user1)
    comment = question.comments.create!(body: "Nice comment", user_id: user1.id)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user2)

    visit question_path(question)

    within('#question-comments') do
      expect(page).to_not have_button("Delete Comment")
    end
  end
end
