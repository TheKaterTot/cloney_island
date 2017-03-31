require 'rails_helper'

feature "user visits root and clicks 'Ask a question'" do
  scenario "they are directed to a form to create a question" do
    Fabricate(:category, name: "Dogs")
    user = Fabricate(:user, id: 1)


    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit root_path

    within(".categories") do
      click_link("Dogs")
    end

    expect(current_path).to eq(root_path)

    within("#nav-mobile.left") do
      click_link("Ask Question")
    end

    expect(current_path).to eq(new_question_path)

    within("#new-question-form") do
      expect(page).to have_content("Dogs")
      expect(page).to_not have_content("Cats")
    end
  end
end
