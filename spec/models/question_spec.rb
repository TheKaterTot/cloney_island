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
    it "checks if a user's upvote exists on a question and deletes it" do
      user_1 = Fabricate(:user)
      user_2 = Fabricate(:user)
      user_3 = Fabricate(:user)
      user_4 = Fabricate(:user)

      question = Fabricate(:question, title: "Why are we the best?", body: "Bless Up", user: user_1)

      upvote_1 = question.upvotes.create(creator: user_2.id, user_id: user_1.id)
      upvote_2 = question.upvotes.create(creator: user_3.id, user_id: user_1.id)
      upvote_3 = question.upvotes.create(creator: user_4.id, user_id: user_1.id)

      expect(question.upvotes.count).to be(3)

      question.current_user_upvote_correction(question, user_2.id)

      expect(question.upvotes.count).to be(2)
    end
  end

    describe ".current_user_upvote_correction" do
      it "checks if a user's upvote exists on a question and deletes it" do
        user_1 = Fabricate(:user)
        user_2 = Fabricate(:user)
        user_3 = Fabricate(:user)
        user_4 = Fabricate(:user)

        question = Fabricate(:question, title: "Why are we the best?", body: "Bless Up", user: user_1)

        downvote_1 = question.downvotes.create(creator: user_2.id, user_id: user_1.id)
        downvote_2 = question.downvotes.create(creator: user_3.id, user_id: user_1.id)
        downvote_3 = question.downvotes.create(creator: user_4.id, user_id: user_1.id)

        expect(question.downvotes.count).to be(3)

        question.current_user_downvote_correction(question, user_2.id)

        expect(question.downvotes.count).to be(2)
      end
    end
end