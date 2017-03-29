require 'rails_helper'

describe 'questions' do
  describe 'order_by_update' do
    it 'orders questions by date updated' do
      user            = Fabricate(:user)
      category        = Fabricate(:category)
      first_question  = Fabricate(:question, user:user, category:category)
      second_question = Fabricate(:question, user:user, category:category)

      questions = Question.order_by_update

      expect(questions.first).to eq(first_question)
    end
  end

  describe 'find_user' do
    it 'finds the name of the user associated with a question' do
      user            = Fabricate(:user, name:"BurgerBob")
      second_user            = Fabricate(:user, name:"Jabrony")
      category        = Fabricate(:category)
      first_question  = Fabricate(:question, user:user, category:category)
      second_question = Fabricate(:question, user:second_user, category:category)

      name        = first_question.find_user
      second_name = second_question.find_user

      expect(name).to eq("BurgerBob")
      expect(name).to_not eq("Jabrony")

      expect(second_name).to eq("Jabrony")
      expect(second_name).to_not eq("BurgerBob")
    end
  end

  describe 'find_category' do
    it 'finds the name of the category associated with a question' do
      category        = Fabricate(:category, name: "Comp Sci")
      category_two    = Fabricate(:category, name: "Philosophy")
      first_question  = Fabricate(:question, category:category)
      second_question = Fabricate(:question, category:category_two)

      category        = first_question.find_category
      second_category = second_question.find_category

      expect(category).to eq("Comp Sci")
      expect(category).to_not eq("Philosophy")

      expect(second_category).to eq("Philosophy")
      expect(second_category).to_not eq("Comp Sci")
    end
  end
end
