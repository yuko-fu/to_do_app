class AddColumnTasks < ActiveRecord::Migration[6.1]
  def change
    add_column :tasks, :end_date, :date, null: false, default: -> { "(CURRENT_DATE)" }
  end
end
