require 'rails_helper'

RSpec.describe Comment, type: :model do
  context "relationships" do
    it { should belong_to(:commentable) }
    it { should belong_to(:user) }
    it { should have_many(:downvotes) }
    it { should have_many(:upvotes) }
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

  describe '#find_user' do
    it 'returns the owner of comment' do
      user = Fabricate(:user)
      user2 = Fabricate(:user)
      question = Fabricate(:question, title: 'test', user: user)
      comment = question.comments.create(body: 'test', user: user )

      expect(comment.find_user).to eq(user.name)
    end
  end

  describe '#update_date' do
    it ' returns formatted date for view' do
      user = Fabricate(:user)
      user2 = Fabricate(:user)
      question = Fabricate(:question, title: 'test', user: user)
      comment = question.comments.create(body: 'test', user: user )
      comment_updated_at_date = comment.updated_at

      expect(comment.update_date).to eq(comment_updated_at_date.strftime("%D at %r"))
    end
  end

  describe '#self.populate_comment' do
    it 'populates answer comment based on params from request' do
      user = Fabricate(:user)
      question = Fabricate(:question)
      answer = Fabricate(:answer, question: question)
      comment_params = {:body=>"Wow wow wow!", :answer=>"1884", :question =>"3"}

      comment = Comment.populate_comment(comment_params, question, answer)

      expect(comment.body).to eq(comment_params[:body])
      expect(comment.commentable_type).to eq("Answer")
    end

    it 'populates question comment based on params from request' do
      user = Fabricate(:user)
      question = Fabricate(:question)
      answer = Fabricate(:answer, question: question)
      comment_params = {:body=>"Wow wow wow!", :question =>"3"}

      comment = Comment.populate_comment(comment_params, question, answer)

      expect(comment.body).to eq(comment_params[:body])
      expect(comment.commentable_type).to eq("Question")
    end
  end

  describe ".current_user_upvote_correction" do
    it "checks if a user's upvote exists on a comment and deletes it" do
      user_1 = Fabricate(:user)
      user_2 = Fabricate(:user)
      user_3 = Fabricate(:user)
      user_4 = Fabricate(:user)
      category = Fabricate(:category, name: "DJ Khaled")

      question = Fabricate(:question, title: "Why are we the best?", body: "Bless Up", user: user_1, category: category)

      comment = question.comments.create(body: "Bless Up", user: user_1)

      upvote_1 = comment.upvotes.create(creator: user_2.id, user_id: user_1.id)
      upvote_2 = comment.upvotes.create(creator: user_3.id, user_id: user_1.id)
      upvote_3 = comment.upvotes.create(creator: user_4.id, user_id: user_1.id)

      expect(comment.upvotes.count).to be(3)

      comment.current_user_upvote_correction(user_2.id)

      expect(comment.upvotes.count).to be(2)
    end
  end

  describe ".current_user_downvote_correction" do
    it "checks if a user's downvote exists on an answer and deletes it" do
      user_1 = Fabricate(:user)
      user_2 = Fabricate(:user)
      user_3 = Fabricate(:user)
      user_4 = Fabricate(:user)
      category = Fabricate(:category, name: "DJ Khaled")

      question = Fabricate(:question, title: "Why are we the best?", body: "Bless Up", user: user_1, category: category)

      comment = question.comments.create(body: "Bless Up", user: user_1)

      downvote_1 = comment.downvotes.create(creator: user_2.id, user_id: user_1.id)
      downvote_2 = comment.downvotes.create(creator: user_3.id, user_id: user_1.id)
      downvote_3 = comment.downvotes.create(creator: user_4.id, user_id: user_1.id)

      expect(comment.downvotes.count).to be(3)

      comment.current_user_downvote_correction(user_2.id)

      expect(comment.downvotes.count).to be(2)
    end
  end
end
