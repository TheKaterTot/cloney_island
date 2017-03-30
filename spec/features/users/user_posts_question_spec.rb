require "rails_helper"

feature "user visits root and clicks 'Ask a question'" do
  scenario "they are directed to a form to create a question" do
    Fabricate(:category, name: "Dogs")
    user = Fabricate(:user, id: 1)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit root_path

    within("#nav-mobile.left") do
      click_link("Ask Question")
    end

    expect(current_path).to eq(new_question_path)

    fill_in("Title", :with => "Why?")
    fill_in("Body", :with => "Why must I be a teenager in love?")
    select("Dogs", :from => "question_category_id")

    click_button("Submit")

    question = Question.last

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

  feature "and they incorrectly enter question parameters" do
    scenario "they cannot create a question" do
      Fabricate(:category, name: "Dogs")
      user = Fabricate(:user, id: 1)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit root_path

      within("#nav-mobile.left") do
        click_link("Ask Question")
      end

      expect(current_path).to eq(new_question_path)

      fill_in("Body", :with => "Why must I be a teenager in love?")
      select("Dogs", :from => "question_category_id")

      click_button("Submit")

      expect(current_path).to eq(new_question_path)

      expect(page).to have_content("Failed to create question")
    end
  end
end
