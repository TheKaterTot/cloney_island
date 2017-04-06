require 'rails_helper'

describe "recent_questions API" do
  it "returns 5 most recent questions" do
    category = Fabricate(:category, name: "we the best")
    user = Fabricate(:user, name: "we_the_best")
    question_1 = Fabricate(:question, title: "Why don't they want us to win? 1", body: "We have the keys to success, bless up. 1", user: user, category: category)
    question_2 = Fabricate(:question, title: "Why don't they want us to win? 2", body: "We have the keys to success, bless up. 2", user: user, category: category)
    question_3 = Fabricate(:question, title: "Why don't they want us to win? 3", body: "We have the keys to success, bless up. 3", user: user, category: category)
    question_4 = Fabricate(:question, title: "Why don't they want us to win? 4", body: "We have the keys to success, bless up. 4", user: user, category: category)
    question_5 = Fabricate(:question, title: "Why don't they want us to win? 5", body: "We have the keys to success, bless up. 5", user: user, category: category)
    question_6 = Fabricate(:question, title: "Why don't they want us to win? 6", body: "We have the keys to success, bless up. 6", user: user, category: category)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    get '/api/v1/questions/recent_questions'

    expect(response).to be_success

    questions       = JSON.parse(response.body)
    question        = questions.first
    second_question = questions.second
    last_question   = questions.last

    expect(questions.count).to eq(5)

    expect(question).to have_key "title"
    expect(question).to have_key "body"
    expect(question).to have_key "category_name"
    expect(question).to have_key "created_at"

    expect(question["title"]).to eq("Why don't they want us to win? 1")
    expect(question["body"]).to eq("We have the keys to success, bless up. 1")
    expect(question["category_name"]).to eq("we the best")
    expect(question["created_at"].to_date.class).to eq(Date)

    expect(second_question["title"]).to eq("Why don't they want us to win? 2")
    expect(second_question["body"]).to eq("We have the keys to success, bless up. 2")
    expect(second_question["category_name"]).to eq("we the best")

    expect(last_question["title"]).to eq("Why don't they want us to win? 5")
    expect(last_question["body"]).to eq("We have the keys to success, bless up. 5")
    expect(last_question["category_name"]).to eq("we the best")
  end
end