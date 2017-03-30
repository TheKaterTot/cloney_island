require "rails_helper"

feature "user answers question" do
  scenario "they fill out the form on the question show page" do
    user = Fabricate(:user)
    question = Fabricate(:question, user: user)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)


    visit question_path(question)

    fill_in "Enter text", with: "Dumb question"
    click_button("Submit")

    expect(current_path).to eq(question_path(question))
    within(".question-answers .question-answer:nth-child(1)") do
      expect(page).to have_content("Dumb question")
    end
  end

  scenario "they fill out the fomr incorrectly on the question show page" do
    user = Fabricate(:user)
    question = Fabricate(:question, user: user)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)


    visit question_path(question)

    click_button("Submit")

    expect(current_path).to eq(question_path(question))


    expect(page).to have_content("Your comment was not successful.")
  end
end
