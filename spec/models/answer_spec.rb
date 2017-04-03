require 'rails_helper'

RSpec.describe Answer, type: :model do
  context "relationships" do
    it { should have_many(:comments) }
    it { should belong_to(:user) }
    it { should belong_to(:question) }
    it { should have_many(:upvotes) }
    it { should have_many(:downvotes) }
  end

  context "validations" do
    it { should validate_presence_of(:body) }
  end

  describe ".current_user_upvote_correction" do
    it "checks if a user's upvote exists on an answer and deletes it" do
      user_1 = Fabricate(:user)
      user_2 = Fabricate(:user)
      user_3 = Fabricate(:user)
      user_4 = Fabricate(:user)
      category = Fabricate(:category, name: "DJ Khaled")

      question = Fabricate(:question, title: "Why are we the best?", body: "Bless Up", user: user_1, category: category)

      answer = Fabricate(:answer, body: "Bless Up", question: question)

      upvote_1 = answer.upvotes.create(creator: user_2.id, user_id: user_1.id)
      upvote_2 = answer.upvotes.create(creator: user_3.id, user_id: user_1.id)
      upvote_3 = answer.upvotes.create(creator: user_4.id, user_id: user_1.id)

      expect(answer.upvotes.count).to be(3)

      answer.current_user_upvote_correction(answer, user_2.id)

      expect(answer.upvotes.count).to be(2)
    end
  end

  describe ".current_user_upvote_correction" do
    it "checks if a user's upvote exists on an answer and deletes it" do
      user_1 = Fabricate(:user)
      user_2 = Fabricate(:user)
      user_3 = Fabricate(:user)
      user_4 = Fabricate(:user)
      category = Fabricate(:category, name: "DJ Khaled")

      question = Fabricate(:question, title: "Why are we the best?", body: "Bless Up", user: user_1, category: category)

      answer = Fabricate(:answer, body: "Bless Up", question: question)

      downvote_1 = answer.downvotes.create(creator: user_2.id, user_id: user_1.id)
      downvote_2 = answer.downvotes.create(creator: user_3.id, user_id: user_1.id)
      downvote_3 = answer.downvotes.create(creator: user_4.id, user_id: user_1.id)

      expect(answer.downvotes.count).to be(3)

      answer.current_user_downvote_correction(answer, user_2.id)

      expect(answer.downvotes.count).to be(2)
    end
  end
end