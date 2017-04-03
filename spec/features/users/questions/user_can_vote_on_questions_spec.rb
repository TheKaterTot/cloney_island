require 'rails_helper'

feature 'user views a question' do
  attr_reader :user, :question
  before(:each) do
    @user = Fabricate(:user, password: 'password')
    @user.roles.create(name: 'registered_user')
    @question = Fabricate(:question)
  end

  scenario 'user can upvote the question' do
    visit question_path(@question)

    
