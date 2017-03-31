class UpdateTimestamps < ActiveRecord::Migration[5.0]
  def up
    Question.where(created_at: nil).update_all(created_at: Time.now)
    Question.where(updated_at: nil).update_all(updated_at: Time.now)
    Answer.where(created_at: nil).update_all(created_at: Time.now)
    Answer.where(updated_at: nil).update_all(updated_at: Time.now)
  end
end
