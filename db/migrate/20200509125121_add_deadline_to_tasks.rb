class AddDeadlineToTasks < ActiveRecord::Migration[5.2]
  def change
    add_column :tasks, :deadline, :timestamp, null: false, default: Time.new(2020, 1, 1)
  end
end
