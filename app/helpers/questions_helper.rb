module QuestionsHelper
  def best_answer?(question, answer)
    question.best_answer_id == answer.id
  end
end
