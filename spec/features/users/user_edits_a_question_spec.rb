require "rails_helper"

feature "user visits the question show page" do
  scenario "they click edit question" do
    category = Fabricate(:category, name: "Space")
    user = Fabricate(:user, name: "Space Nerd")
    question = Fabricate(:question,
                                      title: "How high is the ISS?",
                                      body: "So high.",
                                      user: user,
                                      category: category )

    visit question_path(question)

    within("#edit-question") do
      click_on "Edit Question"
    end

    expect(current_path).to eq(edit_question_path(question))

    within("#question-title") do
      fill_in "Title", with: "How many miles above Earth is the ISS?"
    end

    within("#question-body") do
      fill_in "Body", with: "Is it getting farther away?"
      click_on "Submit"
    end

    expect(current_path).to eq(question_path(question))
    expect(page).to have_content("Your question was edited successfully!")
  end
  #scenario - doesn't edit answers
  #scenario - doesn't edit comments
end