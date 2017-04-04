require 'rails_helper'

feature 'users reputation' do
  attr_reader :user,
              :question,
              :answer,
              :comment
  before(:each) do
    @user     = Fabricate(:user, name: 'test')
    @question = Fabricate(:question, user: @user)
    @answer   = Fabricate(:answer, user: @user, question: question)
    question.comments.create(body: 'test', user: user, commentable: question)
    answer.comments.create(body: 'test', user: user, commentable: question)
  end

  scenario 'users reputation increases with a question upvote' do
    login(user.name)

    visit question_path(question)

    expect(user.reputation).to eq(0)

    within("#question-upvote") do
      expect(page).to have_button("Upvote")
      click_on "Upvote"
    end

    visit user_path(user)

    user.reload
    expect(user.reputation).to eq(1)

    within('#user-street-rep') do
      expect(page).to have_content('1')
    end
  end
  scenario 'users reputation increases with an answer upvote' do
    login(user.name)

    visit question_path(question)

    expect(user.reputation).to eq(0)

    within("#answer-upvote") do
      expect(page).to have_button("Upvote")
      click_on "Upvote"
    end

    visit user_path(user)

    user.reload
    expect(user.reputation).to eq(1)

    within('#user-street-rep') do
      expect(page).to have_content('1')
    end
  end

  scenario 'users reputation increases with a question comment upvote' do
    login(user.name)

    visit question_path(question)

    expect(user.reputation).to eq(0)

    within("#question-comment-upvote") do
      expect(page).to have_button("Upvote")
      click_on "Upvote"
    end

    visit user_path(user)

    user.reload
    expect(user.reputation).to eq(1)

    within('#user-street-rep') do
      expect(page).to have_content('1')
    end
  end
  scenario 'users reputation increases with an answer comment upvote' do
    login(user.name)

    visit question_path(question)

    expect(user.reputation).to eq(0)

    within("#answer-comment-upvote") do
      expect(page).to have_button("Upvote")
      click_on "Upvote"
    end

    visit user_path(user)

    user.reload
    expect(user.reputation).to eq(1)

    within('#user-street-rep') do
      expect(page).to have_content('1')
    end
  end
  scenario 'users reputation increases with a best answer' do
    login(user.name)

    visit question_path(question)

    expect(user.reputation).to eq(0)

    within(".best-answer-button") do
      expect(page).to have_button("Select As Best Answer")
      click_on "Select As Best Answer"
    end

    visit user_path(user)

    user.reload
    expect(user.reputation).to eq(1)

    within('#user-street-rep') do
      expect(page).to have_content('1')
    end
  end
  scenario 'users reputation decreases with a question downvote' do
    login(user.name)

    visit question_path(question)

    expect(user.reputation).to eq(0)

    within("#question-downvote") do
      expect(page).to have_button("Downvote")
      click_on "Downvote"
    end

    visit user_path(user)

    user.reload
    expect(user.reputation).to eq(-1)

    within('#user-street-rep') do
      expect(page).to have_content('-1')
    end
  end
  scenario 'users reputation decreases with an answer downvote' do
    login(user.name)

    visit question_path(question)

    expect(user.reputation).to eq(0)

    within("#answer-downvote") do
      expect(page).to have_button("Downvote")
      click_on "Downvote"
    end

    visit user_path(user)

    user.reload
    expect(user.reputation).to eq(-1)

    within('#user-street-rep') do
      expect(page).to have_content('-1')
    end
  end

  scenario 'users reputation decreases with a question comment downvote' do
    login(user.name)

    visit question_path(question)

    expect(user.reputation).to eq(0)

    within("#question-comment-downvote") do
      expect(page).to have_button("Downvote")
      click_on "Downvote"
    end

    visit user_path(user)

    user.reload
    expect(user.reputation).to eq(-1)

    within('#user-street-rep') do
      expect(page).to have_content('-1')
    end
  end
  scenario 'users reputation decreases with an answer comment downvote' do
    login(user.name)

    visit question_path(question)

    expect(user.reputation).to eq(0)

    within("#answer-comment-downvote") do
      expect(page).to have_button("Downvote")
      click_on "Downvote"
    end

    visit user_path(user)

    user.reload
    expect(user.reputation).to eq(-1)

    within('#user-street-rep') do
      expect(page).to have_content('-1')
    end
  end
end
