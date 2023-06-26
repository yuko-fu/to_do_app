class ChangeDateStatusToTasks < ActiveRecord::Migration[6.1]
  def change
    change_column :tasks, :status, :integer
  end
end
