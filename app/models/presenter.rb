class Presenter

  def all_categories
    Category.all
  end

  def show_questions(category)
    if category
      Question.where(category: Category.find(category)).first(25)
    else
      Question.order_by_update.first(25)
    end
  end
end
