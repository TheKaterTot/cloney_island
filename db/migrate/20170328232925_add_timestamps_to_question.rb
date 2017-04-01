class AddTimestampsToQuestion < ActiveRecord::Migration[5.0]
  def change
    add_column :questions, :created_at, :timestamp
    add_column :questions, :updated_at, :timestamp
  end
end
