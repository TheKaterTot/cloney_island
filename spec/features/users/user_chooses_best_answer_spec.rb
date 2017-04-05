require "rails_helper"

feature "user can choose an answer as the best answer" do
  let(:user) { Fabricate(:user) }
  let(:question) { Fabricate(:question, user: user) }

  before do
    Fabricate(:answer, question: question)
    Fabricate(:answer, question: question)
  end

  scenario "from their question's show page" do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit question_path(question)

    within(all(".best-answer-button").first) do
      click_on("Select As Best Answer")
    end

    expect(current_path).to eq(question_path(question))

    expect(all("#best-answer").count).to eq(1)
  end
end
