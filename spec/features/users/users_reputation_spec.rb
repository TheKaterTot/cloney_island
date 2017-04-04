require 'rails_helper'

feature 'users reputation' do
  attr_reader :user,
              :question,
              :answer,
              :comment,
              :user2
  before(:each) do
    @user     = Fabricate(:user, name: 'test')
    @user2    = Fabricate(:user)
    @question = Fabricate(:question, user: @user)
    @answer   = Fabricate(:answer, user: @user)
    @comment   = Fabricate(:answer, user: @user)
  end

  scenario 'users reputation increases with a question upvote' do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user2)

    visit question_path(question)

    expect(user.reputation).to eq(0)

    within("#question-upvote") do
      expect(page).to have_button("Upvote")
      click_on "Upvote"
    end
    visit root_path
    visit user_path(user)
byebug
    within('#user-street-rep') do
      expect(page).to have_content('1')
    end
  end
end
