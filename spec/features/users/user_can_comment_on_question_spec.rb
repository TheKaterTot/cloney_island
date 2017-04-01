require 'rails_helper'

describe 'when a user visits a question show page' do
  it 'they can comment on a question' do
    user = Fabricate(:user, id: 1)
    question = Fabricate(:question, user: user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit question_path(question)

    within(".question") do
      fill_in "Add Comment", with: "This is an awesome comment"
      click_on "Add Comment"
    end
save_and_open_page

  end
end
