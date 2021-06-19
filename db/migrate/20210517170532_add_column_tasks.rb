class AddColumnTasks < ActiveRecord::Migration[5.2]
  def change
    add_column :tasks, :status, :integer, default: 0
    add_column :tasks, :expired_at, :datetime
    add_column :tasks, :priority, :integer, default: 0
  end
end
