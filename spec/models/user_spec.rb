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

  describe '.comments_to_recent_activity' do
    it 'returns 5 most recent comments to user activity' do
      user = Fabricate(:user)
      user2 = Fabricate(:user)
      question1 = Fabricate(:question, title: 'test', user: user)
      answer1 = Fabricate(:answer, user: user, question: question1)
      user2.comments.create(body: 'test',
                            commentable: question1,
                            updated_at: '2017-03-21 19:55:40')
      user2.comments.create(body: 'test',
                            commentable: question1,
                            updated_at: '2017-03-22 19:55:40')
      user2.comments.create(body: 'test',
                            commentable: question1,
                            updated_at: '2017-03-23 19:55:40')
      user2.comments.create(body: 'test',
                            commentable: question1,
                            updated_at: '2017-03-24 19:55:40')
      user2.comments.create(body: 'test',
                            commentable: question1,
                            updated_at: '2017-03-25 19:55:40')

      old_comment = user2.comments.create(body: 'test',
                                          commentable: answer1,
                                          updated_at: '2017-03-26 19:55:40')

      comments = user.comments_to_recent_activity

      expect(comments.count).to eq(5)

      expect(comments[0].source_question.user).to eq(user)
      expect(comments[1].source_question.user).to eq(user)
      expect(comments[2].source_question.user).to eq(user)
      expect(comments[3].source_question.user).to eq(user)
      expect(comments[4].source_question.user).to eq(user)

      expect(comments.include?(old_comment)).to eq(false)
    end
  end

  describe '.admin?' do
    it 'returns true if the user has an admin role' do
      user = Fabricate(:user)
      user.roles.create(name: 'admin')

      expect(user.admin?).to eq(true)
    end

    it 'returns false if a user does not have an admin role' do
      user = Fabricate(:user)

      expect(user.admin?).to eq(false)
    end
  end
  describe '.registered_user?' do
    it 'returns true if the user has an registered_user role' do
      user = Fabricate(:user)
      user.roles.create(name: 'registered_user')

      expect(user.registered_user?).to eq(true)
    end

    it 'returns false if a user does not have an registered_user role' do
      user = Fabricate(:user, roles: [])

      expect(user.registered_user?).to eq(false)
    end
  end

  describe ".upvote_count" do
    it "returns the count of the existing upvotes for a user from a question" do
      user_1 = Fabricate(:user)
      user_2 = Fabricate(:user)
      user_3 = Fabricate(:user)
      user_4 = Fabricate(:user)


      question = Fabricate(:question, title: "Why are we the best?", body: "Bless Up", user: user_1)

      upvote_1 = question.upvotes.create(creator: user_2.id, user_id: user_1.id)
      upvote_2 = question.upvotes.create(creator: user_3.id, user_id: user_1.id)
      upvote_3 = question.upvotes.create(creator: user_4.id, user_id: user_1.id)

      expect(user_1.upvote_count).to eq(3)
    end
  end

  describe ".downvote_count" do
    it "returns the count of the existing downvotes for a user from a question" do
      user_1 = Fabricate(:user)
      user_2 = Fabricate(:user)
      user_3 = Fabricate(:user)
      user_4 = Fabricate(:user)


      question = Fabricate(:question, title: "Why are we the best?", body: "Bless Up", user: user_1)

      downvote_1 = question.downvotes.create(creator: user_2.id, user_id: user_1.id)
      downvote_2 = question.downvotes.create(creator: user_3.id, user_id: user_1.id)
      downvote_3 = question.downvotes.create(creator: user_4.id, user_id: user_1.id)

      expect(user_1.downvote_count).to eq(3)
    end
  end

  describe ".reputation_count" do
    it "returns the reputation count for a user from a question" do
      user_1 = Fabricate(:user)
      user_2 = Fabricate(:user)
      user_3 = Fabricate(:user)
      user_4 = Fabricate(:user)

      question = Fabricate(:question, title: "Why are we the best?", body: "Bless Up", user: user_1)

      upvote_1 = question.upvotes.create(creator: user_2.id, user_id: user_1.id)
      upvote_2 = question.upvotes.create(creator: user_3.id, user_id: user_1.id)
      upvote_3 = question.upvotes.create(creator: user_4.id, user_id: user_1.id)

      downvote_1 = question.downvotes.create(creator: user_2.id, user_id: user_1.id)

      expect(user_1.reputation_count).to eq(2)
    end
  end
end
