require 'rails_helper'

feature "logged in user visits the question show page" do
  scenario "user owns answer and they click edit answer" do
    category = Fabricate(:category, name: "DJ Khaled")
    user = Fabricate(:user, name: "we the best")
    user.roles.create(name: 'registered_user')

    question = Fabricate(:question,
                                      title: "Why don't they want us to win?",
                                      body: "We the best. Bless up.",
                                      user: user,
                                      category: category)
    answer = question.answers.create(body: "Grateful. Keys to success.", user: user)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit question_path(question)

    within(".question-answers .question-answer:nth-child(1)") do
      expect(page).to have_content("Grateful. Keys to success.")
    end

    first('#answer-edit-button').click_button('Edit Answer')

    expect(current_path).to eq(edit_question_path(question))

    within("#answer-body") do
      fill_in "Body", with: "We've got the keys to success."
    end

    expect(current_path).to eq(question_path(question))
    expect(page).to have_content("Your answer was edited successfully!")

    within(".question-answers .question-answer:nth-child(1)") do
      expect(page).to have_content("We've got the keys to success.")
    end
  end
end