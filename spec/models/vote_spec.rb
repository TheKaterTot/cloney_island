require 'rails_helper'

RSpec.describe Vote, type: :model do
  context "relationships" do
    it { should belong_to(:votable) }
    it { should belong_to(:user) }
  end

  context "validations" do
    it do
      should validate_inclusion_of(:value).
        in_array([-1, 0, 1])
      end
  end

  describe "creates a vote" do
    it "from a question" do
      #user creates a question
      #question creates a vote
      user = Fabricate(:user)
      question = Fabricate(:question, user: user)
      vote = question.votes.create(value: 1)

      expect(vote.value).to eq(1)
    end
  end

  describe "#votes_value returns the total vote value" do
    it "from a question" do
      user = Fabricate(:user)
      user_1 = Fabricate(:user)
      user_2 = Fabricate(:user)
      user_3 = Fabricate(:user)

      question = Fabricate(:question, user: user)
      vote = question.votes.create(value: 1)
      vote_1 = question.votes.create(value: 1, user_id: user_1.id)
      vote_2 = question.votes.create(value: 1, user_id: user_2.id)
      vote_3 = question.votes.create(value: 1, user_id: user_3.id)

      expect(question.votes_value).to eq(4)
    end

    it "from question returns 0 if a question has no votes" do
      user = Fabricate(:user)

      question = Fabricate(:question, user: user)

      expect(question.votes_value).to eq(0)
    end
  end
end