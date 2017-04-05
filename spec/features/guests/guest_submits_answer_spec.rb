require "rails_helper"

feature "guests cannot submit answer" do
  scenario "they see a flash message telling them to sign in" do

    question = Fabricate(:question)

    visit question_path(question)

    fill_in "Enter text", with: "Dumb question"
    click_button("Submit")

    expect(current_path).to eq('/')

    within(".alert-danger") do
      expect(page).to have_content("You are not authorized to do that. Please log in, create an account or validate your account.")
    end
  end
end
