require 'rails_helper'

feature "logged in user votes on a question" do
  scenario "user clicks upvote" do
    category = Fabricate(:category, name: "Space")
    user = Fabricate(:user, name: "Space Nerd")
    question = Fabricate(:question,
                                      title: "How high is the ISS?",
                                      body: "In miles.",
                                      user: user,
                                      category: category )
    question.votes.create(value: "1")

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit question_path(question)

    within("#votes") do
      expect(page).to have_content("0")
    end

    within("#upvote-question") do
      click_on "Upvote"
    end

    expect(current_path).to eq(question_path(question))

    within("#votes") do
      expect(page).to have_content("1")
    end
  end
end