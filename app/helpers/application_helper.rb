module ApplicationHelper
  def show_errors(object, field)
    if object.errors.any?
      if !object.errors.messages[field].blank?
        content_tag(:p, class: "error") do
        field.to_s.capitalize + " " + object.errors.messages[field].first
        end
      end
    end
  end
end
