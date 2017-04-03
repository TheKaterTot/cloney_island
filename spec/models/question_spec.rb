require 'rails_helper'

RSpec.describe Question, type: :model do
  context "relationships" do
    it { should belong_to(:user) }
    it { should belong_to(:category) }
    it { should have_many(:answers) }
    it { should have_many(:comments) }
    it { should have_many(:upvotes) }
    it { should have_many(:downvotes) }
  end

  context "validations" do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:body) }
  end

  describe ".find_user" do
    it "returns the question user's name" do
      user = Fabricate(:user, name: "we the best")
      question = Fabricate(:question, user: user)

      expect(question.find_user).to eq("we the best")
    end
  end

  describe ".find_category" do
    it "returns the question category's name" do
      category = Fabricate(:category, name: "DJ Khaled")
      question = Fabricate(:question, title: "Why do they try to stop us?", category: category)

      expect(question.find_category).to eq("DJ Khaled")
    end
  end

  describe ".answer_count" do
    it "returns the question's answer count" do
      user = Fabricate(:user, name: "we the best")
      question = Fabricate(:question, title: "Why do they try to stop us?", user: user)
      answer_1 = question.answers.create(body: "blessup", user: user)
      answer_2 = question.answers.create(body: "we the best", user: user)
      answer_3 = question.answers.create(body: "$$$", user: user)

      expect(question.answer_count).to eq(3)
    end
  end

  describe ".current_user_upvote_correction" do
    it "returns the question's answer count" do

    end
  end
end