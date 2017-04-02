require "rails_helper"

feature "logged in user visits the question show page" do
  scenario "user owns question and they click edit question" do
    category = Fabricate(:category, name: "Space")
    user = Fabricate(:user, name: "Space Nerd")
    user.roles.create(name: 'registered_user')

    question = Fabricate(:question,
                                      title: "How high is the ISS?",
                                      body: "So high.",
                                      user: user,
                                      category: category )

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

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

    within("#question-body") do
      expect(page).to have_content("Is it getting farther away?")
    end
  end

  scenario "user does not own question and cannot edit a question" do
    category = Fabricate(:category, name: "Space")
    user_1 = Fabricate(:user, name: "Space Nerd")
    user_2 = Fabricate(:user, name: "Just Not")
    question = Fabricate(:question,
                                      title: "How high is the ISS?",
                                      body: "So high.",
                                      user: user_1,
                                      category: category )

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user_2)

    visit question_path(question)

    within("#edit-question") do
      expect(page).to_not have_content("Edit Question")
    end

    expect(current_path).to eq(question_path(question))
  end
end