require "rails_helper"

feature "logged in user visits the question show page" do
  scenario "they see and click delete question" do

    category = Fabricate(:category, name: "Space")
    user = Fabricate(:user, name: "Space Nerd")
    question = Fabricate(:question,
                                      title: "How high is the ISS?",
                                      body: "So high.",
                                      user: user,
                                      category: category )

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit question_path(question)

    within("#delete-question") do
      click_on "Delete Question"
    end

    expect(current_path).to eq(root_path)
    expect(page).to have_content("Your question was deleted successfully!")
  end


end
