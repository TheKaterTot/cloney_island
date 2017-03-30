require "rails_helper"

feature "guest clicks Add Question" do
  scenario "they are redirected to login page" do
    visit root_path

    within("#nav-mobile.left") do
      click_link("Ask Question")
    end

    expect(current_path).to eq(login_path)
  end
end
