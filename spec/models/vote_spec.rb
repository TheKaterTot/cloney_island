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
end