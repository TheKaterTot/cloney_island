require "rails_helper"

feature "user answers question" do
  scenario "they fill out the form on the question show page" do
    user = Fabricate(:user)
    question = Fabricate(:question, user: user)

    visit question_path(question)

    fill_in "Enter text", with: "Dumb question"
    click_button("Submit")

    expect(current_path).to eq(question_path(question))
    within(".question-answers .question-answer:nth-child(1)") do
      expect(page).to have_content("Dumb question")
    end
  end
end
