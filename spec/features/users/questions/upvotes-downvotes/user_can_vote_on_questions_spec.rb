require 'rails_helper'

feature 'user views a question' do
  attr_reader :user, :question

  scenario 'user can upvote and downvote the question' do
    @user = Fabricate(:user, password: 'password', id:2)
    @user.roles.create(name: 'registered_user')
    category = Fabricate(:category)
    question = @user.questions.create(title:"eh", body:"what", category:category)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit question_path(question)

    within("#question-upvote") do
      find("[name=button]").click
    end

    expect(current_path).to eq(question_path(question))

    expect(user.reputation_count).to eq(1)

    within("#question-downvote") do
      find("[name=button]").click
    end

    expect(current_path).to eq(question_path(question))

    expect(user.reputation_count).to eq(-1)
  end
end
