require 'rails_helper'

describe 'when a user visits a question show page' do
  it 'they can comment on an answer' do
    user = Fabricate(:user, id: 1)
    question = Fabricate(:question, user: user)
    answer = Fabricate(:answer, question: question, user: user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit question_path(question)

    within('.comment-on-answer') do
      fill_in 'Add Comment', with: "Awesome answer comment!"
      click_on 'Add Comment'
    end

    within('#answer-comment-body') do
      expect(page).to have_content("Awesome answer comment!")
    end

    within('#answer-comment-details') do
      expect(page).to have_content("#{user.name}")
      expect(page).to have_content("#{Comment.last.update_date}")
    end

    within('.flash-message') do
      expect(page).to have_content("Comment successfully created")
    end
  end

  it 'they cannot leave a blank comment' do
    user = Fabricate(:user, id: 1)
    question = Fabricate(:question, user: user)
    answer = Fabricate(:answer, question: question, user: user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit question_path(question)

    within('.comment-on-answer') do
      click_on 'Add Comment'
    end

    within('.flash-message') do
      expect(page).to have_content("Comment failed. Please re-enter your comment.")
    end
  end
end
