class Task < ApplicationRecord
  validates :task_name, presence: true
  validates :content, presence: true
  enum status: {
    未着手: 0,
    着手中: 1,
    完了: 2,
  }
  enum priority: {
    高: 0,
    中: 1,
    低: 2,
  }
  scope :task_name_search, -> (task_name) {where('task_name LIKE ?', task_name)}
  scope :status_search, -> (status) {where(status: status)}
end
