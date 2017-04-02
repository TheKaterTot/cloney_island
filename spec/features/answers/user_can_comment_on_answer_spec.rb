require 'rails_helper'

describe 'when a user visits a question show page' do
  it 'they can comment on an answer' do
    user = Fabricate(:user, id: 1)
    question = Fabricate(:question, user: user)
    answer = Fabricate(:answer, question: question, user: user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit question_path(question)
    save_and_open_page
  
  end
end
