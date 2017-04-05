class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def updated_date_and_time
    updated_at.strftime("%b %e, %l:%M %p")
  end

  def find_user_id
    user.id
  end

  def find_user
    user.name unless user.nil?
  end
end
