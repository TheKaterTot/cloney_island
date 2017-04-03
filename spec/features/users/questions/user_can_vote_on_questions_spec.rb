require 'rails_helper'

feature 'user views a question' do
  attr_reader :user, :question

  scenario 'user can upvote the question' do
    @user = Fabricate(:user, password: 'password', id:2)
    @user.roles.create(name: 'registered_user')
    category = Fabricate(:category)
    question = @user.questions.create(title:"eh", body:"what", category:category)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit question_path(question)

    within("#question-upvote") do
      expect(page).to have_button("Upvote")
    end

    within("#question-downvote") do
      expect(page).to have_button("Downvote")
    end

    within("#question-upvote") do
      click_button("Upvote")
    end

    expect(current_path).to eq(question_path(question))

    expect(user.reputation_count(user)).to eq(1)

    expect(page).to_not have_css("#question-upvote")

    within("#question-downvote") do
      expect(page).to have_button("Downvote")
      click_button("Downvote")
    end

    expect(current_path).to eq(question_path(question))

    expect(user.reputation_count(user)).to eq(-1)

  end
end
