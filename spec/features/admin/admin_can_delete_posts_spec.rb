require 'rails_helper'

feature 'admin can delete posts' do

  attr_reader :admin, :question, :answer
  before(:each) do
    @admin    = Fabricate(:user, password: 'password')
    @admin.roles.create(name: 'admin')
    @question = Fabricate(:question)
    @answer   = Fabricate(:answer, question: question)
  end
  scenario 'admin can delete answers from question show page' do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit question_path(question)

      first('.question-answer').click_link('Delete Answer') 
  end
end
