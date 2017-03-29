class Presenter

  def all_questions
    Question.all.first(25)
  end

  def all_categories
    Category.all
  end
end
