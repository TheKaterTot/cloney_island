require 'rails_helper'

feature 'user views a question' do
  attr_reader :user, :question
  before(:each) do
    @user = Fabricate(:user, password: 'password')
    @user.roles.create(name: 'registered_user')
    @question = Fabricate(:question)
  end
  scenario 'question has comments' do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    comment = question.comments.create!(body: "Answer comment!",
                                         user_id: user.id)
    comment2 = question.comments.create!(body: "Another comment!",
                                         user_id: user.id)

    visit question_path(question)

    expect(page).to have_css('#question-comments')

    within('#question-comments') do
      expect(page).to have_content(comment.body)
      expect(page).to have_content(comment2.body)
    end

  end
  scenario 'question has no comments' do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit question_path(question)

    expect(page).to_not have_css('#question-comment-body')

  end
end
