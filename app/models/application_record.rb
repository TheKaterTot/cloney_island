class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def updated_date_and_time
    updated_at.strftime("%b %e, %l:%M %p")
  end
end
