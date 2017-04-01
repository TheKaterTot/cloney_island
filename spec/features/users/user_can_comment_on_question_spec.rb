require 'rails_helper'

describe 'when a user visits a question show page' do
  it 'they can comment on a question' do
    user = Fabricate(:user, id: 1)
    question = Fabricate(:question, user: user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit question_path(question)

    within(".question") do
      fill_in "Add Comment", with: "This is an awesome comment"
      click_on "Add Comment"
    end

    within("#question-comment-body") do
      expect(page).to have_content("This is an awesome comment")
    end

    within("#question-comment-details") do
      expect(page).to have_content(Comment.last.updated_at.strftime("%D at %r"))
    end
  end
end
