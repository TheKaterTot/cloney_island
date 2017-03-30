require "rails_helper"

feature "guests cannot submit answer" do
  scenario "they see a flash message telling them to sign in" do
    question = Fabricate(:question)

    visit question_path(question)

    fill_in "Enter text", with: "Dumb question"
    click_button("Submit")

    expect(current_path).to eq(question_path(question))
    within(".flash-danger") do
      expect(page).to have_content("You must be logged in to do that.")
    end
  end
end
