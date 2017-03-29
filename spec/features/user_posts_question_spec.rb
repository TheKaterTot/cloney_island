require "rails_helper"

feature "user visits root and clicks 'Ask a question'" do
  scenario "they are directed to a form to create a question" do
    visit root_path
    within("#nav-mobile.left") do
      click_link("Ask Question")
    end
    expect(current_path).to eq(new_question_path)

    fill_in("Title", :with => "Why?")
    fill_in("Body", :with => "Why must I be a teenager in love?")

    click_button("Submit")

    question = Question.find(1)
    expect(current_path).to eq(question_path(question))
    within("#question-title") do
      expect(page).to have_content("Why?")
      expect(page).to_not have_content("Anything")
    end
    within("#question-body") do
      expect(page).to have_content("Why must I be a teenager in love?")
      expect(page).to_not have_content("Anything")
    end
  end
end
