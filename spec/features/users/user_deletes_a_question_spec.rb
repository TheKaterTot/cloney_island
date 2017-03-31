require "rails_helper"

feature "user visits the question show page" do
  scenario "they click delete question" do
    category = Fabricate(:category, name: "Space")
    user = Fabricate(:user, name: "Space Nerd")
    question = Fabricate(:question,
                                      title: "How high is the ISS?",
                                      body: "So high.",
                                      user: user,
                                      category: category )

    visit question_path(question)

    within("#delete-question") do
      click_on "Delete Question"
    end

    expect(current_path).to eq(root_path)
    expect(page).to have_content("Your question was deleted successfully!")
  end
  #scenario - also deletes answers
  #scenario - also deletes comments
end
