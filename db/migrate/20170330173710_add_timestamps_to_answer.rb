class AddTimestampsToAnswer < ActiveRecord::Migration[5.0]
  def change
    add_column :answers, :created_at, :timestamp
    add_column :answers, :updated_at, :timestamp
  end
end
