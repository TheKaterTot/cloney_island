class Presenter

  def recent_questions
    Question.order_by_update.first(25)
  end

  def all_categories
    Category.all
  end
end
