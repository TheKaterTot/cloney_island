require 'rails_helper'

feature 'user views a question' do
  attr_reader :user, :question, :answer
  before(:each) do
    @user = Fabricate(:user, password: 'password')
    @user.roles.create(name: 'registered_user')
    @question = Fabricate(:question)
    @answer = Fabricate(:answer, question: question, user: user)
  end
  scenario 'answers have comments' do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    comment1 = answer.comments.create!(body: "Answer comment!",
                                      user_id: user.id)
    comment2 = answer.comments.create!(body: "Another comment!",
                                       user_id: user.id)

    visit question_path(question)

    expect(page).to have_css('#answer-comments')

    within all('#answer-comments').first do
      expect(page).to have_content(comment1.body)
      expect(page).to have_content(comment2.body)
    end
  end

  scenario 'answer has no comments' do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit question_path(question)

    expect(page).to_not have_css('#answer-comments')

  end
end
