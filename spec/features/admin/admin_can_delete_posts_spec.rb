require 'rails_helper'

feature 'admin can delete posts' do
  attr_reader :admin, :question, :answer, :comment1, :comment2

  before(:each) do
    @admin    = Fabricate(:user, password: 'password')
    @admin.roles.create(name: 'admin')
    @question = Fabricate(:question)
    @answer   = Fabricate(:answer, question: question)
    @comment1 = answer.comments.create(body: 'test',
                                       user: admin)
    @comment2 = question.comments.create(body: 'test test',
                                         user: admin)
  end
  scenario 'admin can delete answers from question show page' do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit question_path(question)

      first('#answer-delete-button-admin').click_button('Delete Answer')

      expect(current_path).to eq(question_path(question))

      # expect(page).to_not have_css('#answer-delete-button-admin')
      expect(question.answers.count).to eq(0)
      expect(Comment.count).to eq(1)
      expect(Comment.first.commentable_type).to eq('Question')
  end
  scenario 'admin can delete question from question show page' do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit question_path(question)

      first('#delete-question').click_button('Delete Question')

      expect(current_path).to eq(root_path)

      expect(question.answers.count).to eq(0)
      expect(Question.count).to eq(0)
      expect(Answer.count).to eq(0)
      expect(Comment.count).to eq(0)
  end
end
