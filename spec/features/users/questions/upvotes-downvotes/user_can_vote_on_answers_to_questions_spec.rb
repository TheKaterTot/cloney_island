require 'rails_helper'

feature 'user views a question' do
  attr_reader :user, :question

  scenario 'user can upvote and downvote the answer to a question' do
    @user = Fabricate(:user, password: 'password', id:2)
    @user.roles.create(name: 'registered_user')
    category = Fabricate(:category)
    question = @user.questions.create(title:"eh", body:"what", category:category)
    answer = question.answers.create(body:"blah", user_id:2)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit question_path(question)

    within("#answer-upvote") do
      expect(page).to have_button("Upvote")
    end

    within("#answer-downvote") do
      expect(page).to have_button("Downvote")
    end

    within("#answer-upvote") do
      click_button("Upvote")
    end

    expect(current_path).to eq(question_path(question))

    expect(user.reputation_count(user)).to eq(1)

    expect(page).to_not have_css("#answer-upvote")

    within("#answer-downvote") do
      expect(page).to have_button("Downvote")
      click_button("Downvote")
    end

    expect(current_path).to eq(question_path(question))

    expect(page).to_not have_css("#answer-downvote")

    expect(user.reputation_count(user)).to eq(-1)
  end
end
