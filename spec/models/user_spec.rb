require 'rails_helper'

RSpec.describe User, type: :model do
  context "relationships" do
    it { should have_many(:answers) }
    it { should have_many(:questions) }
    it { should have_many(:comments) }
    it { should have_many(:user_roles) }
    it { should have_many(:roles) }
  end

  context "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:phone) }
  end

  describe '#comments_to_recent_activity' do
    it 'returns 5 most recent comments to user activity' do
      user = Fabricate(:user)
      user2 = Fabricate(:user)
      question1 = Fabricate(:question, title: 'test', user: user)
      answer1 = Fabricate(:answer, user: user, question: question1)
      user2.comments.create(body: 'test', commentable: question1)
      user2.comments.create(body: 'test', commentable: question1)
      user2.comments.create(body: 'test', commentable: answer1)
      user2.comments.create(body: 'test', commentable: answer1)
      user2.comments.create(body: 'test', commentable: answer1)

      comments = user.comments_to_recent_activity

      expect(comments.count).to eq(5)

      expect(comments[0].source_question.user).to eq(user)
      expect(comments[1].source_question.user).to eq(user)
      expect(comments[2].source_question.user).to eq(user)
      expect(comments[3].source_question.user).to eq(user)
      expect(comments[4].source_question.user).to eq(user)
    end
  end
end
