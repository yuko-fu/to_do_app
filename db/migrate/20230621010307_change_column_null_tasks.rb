class ChangeColumnNullTasks < ActiveRecord::Migration[6.1]
  change_column :tasks, :task_name, :string, null: false
  change_column :tasks, :content, :string, null: false
end
