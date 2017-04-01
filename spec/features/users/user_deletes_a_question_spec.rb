require "rails_helper"

feature "logged in user visits the question show page" do
  scenario "user owns the question and sees and clicks delete question" do

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

    within("#delete-question") do
      click_on "Delete Question"
    end

    expect(current_path).to eq(root_path)
    expect(page).to have_content("Your question was deleted successfully!")

    expect{ visit question_path(question) }.to raise_error(ActiveRecord::RecordNotFound)
  end

  scenario "does not own question and does not see delete question" do

    category = Fabricate(:category, name: "Space")
    user_1 = Fabricate(:user, name: "Space Nerd")
    user_1.roles.create(name: 'registered_user')
    user_2 = Fabricate(:user, name: "Just Not")
    user_2.roles.create(name: 'registered_user')

    question = Fabricate(:question,
                                      title: "How high is the ISS?",
                                      body: "So high.",
                                      user: user_1,
                                      category: category )

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user_2)

    visit question_path(question)

    expect(page).to_not have_content("Delete Question")
  end
end
