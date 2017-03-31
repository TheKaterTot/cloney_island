require 'rails_helper'

RSpec.describe Comment, type: :model do
  context "relationships" do
    it { should belong_to(:commentable) }
    it { should belong_to(:user) }
  end

  context "validations" do
    it { should validate_presence_of(:body) }
  end

  describe '#source_question' do
    it 'returns the source question of a comment' do
      user = Fabricate(:user)
      question = Fabricate(:question)
      answer = Fabricate(:answer, question: question)
      comment1 = question.comments.create(body:         'test',
                                          user:         user )
      comment2 = answer.comments.create(body:         'test',
                                        user:         user )


      expect(comment1.source_question).to eq(question)
      expect(comment2.source_question).to eq(question)
    end
  end

  describe '#comments_to_user_activity' do
    it 'returns collection of comments made on user activity' do
      user = Fabricate(:user)
      user2 = Fabricate(:user)
      question1 = Fabricate(:question, title: 'test', user: user)
      answer1 = Fabricate(:answer, user: user, question: question1)
      user2.comments.create(body: 'test', commentable: question1)
      user2.comments.create(body: 'test', commentable: question1)
      user2.comments.create(body: 'test', commentable: question1)
      user2.comments.create(body: 'test', commentable: answer1)
      user2.comments.create(body: 'test', commentable: answer1)

      comments = Comment.comments_to_user_activity(user.id)


      expect(comments.count).to eq(5)
      
      expect(comments[0].source_question).to eq(question1)
      expect(comments[1].source_question).to eq(question1)
      expect(comments[2].source_question).to eq(question1)
      expect(comments[3].source_question).to eq(question1)
      expect(comments[4].source_question).to eq(question1)

      expect(comments[0].commentable).to eq(question1)
      expect(comments[1].commentable).to eq(question1)
      expect(comments[2].commentable).to eq(question1)
      expect(comments[3].commentable).to eq(answer1)
      expect(comments[4].commentable).to eq(answer1)
    end
  end
end
