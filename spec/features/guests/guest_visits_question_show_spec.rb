require "rails_helper"

describe 'when guest visits questions show' do
  attr_reader :user
  before(:each) do
    @user = Fabricate(:user, password: 'password')
  end
  it 'they see questions, answers and comments' do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    category        = Fabricate(:category)
    first_question  = Fabricate(:question, user:user, category:category)
    answer1         = Fabricate(:answer, question:first_question, user:user)
    answer2         = Fabricate(:answer, question:first_question, user:user)
    comment1        = answer1.comments.create!(body: "Answer comment!", user_id: user.id)
    comment2        = answer2.comments.create!(body: "Another Answer comment!", user_id: user.id)
    comment3        = first_question.comments.create!(body: "Question comment!", user_id: user.id)
    visit question_path(first_question)

    expect(page).to have_content("2 Answers")
    expect(page).to have_content("Answer comment!")
    expect(page).to have_content("Question comment!")
    expect(page).to_not have_content("Another question comment!")
    expect(page).to_not have_content("Another answer comment!")
  end

  it 'they cant see comments or answers for other questions' do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    category        = Fabricate(:category)
    first_question  = Fabricate(:question, user:user, category:category)
    second_question = Question.create!(title: "Why not?", body: "Because I said so.", user_id: user.id, category_id: category.id)
    answer1         = Fabricate(:answer, question:first_question, user:user)
    answer2         = Answer.create!(body: "Bad question answer!", question_id: second_question.id, user_id: user.id)
    comment1        = answer1.comments.create!(body: "Answer comment!", user_id: user.id)
    comment2        = answer2.comments.create!(body: "Another Answer comment!", user_id: user.id)
    comment3        = first_question.comments.create!(body: "Question comment!", user_id: user.id)
    comment4        = second_question.comments.create!(body: "Another question comment!", user_id: user.id)

    visit question_path(first_question)

    expect(page).to have_content("How do I make burgers?")
    expect(page).to have_content("Step 1. Get beef. Step 2. Profit")
    expect(page).to have_content("1 Answers")
    expect(page).to have_content("Question comment!")
    expect(page).to_not have_content("Because I said so.")
    expect(page).to_not have_content("Bad question anser")
    expect(page).to_not have_content("Why not?")
    expect(page).to_not have_content("Another question comment!")
    expect(page).to_not have_content("Another answer comment!")
  end
end
