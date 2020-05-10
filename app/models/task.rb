class Task < ApplicationRecord
  validates :name, presence: true, length: {maximum: 30}
  validates :content, presence: true
  scope :search_task_name, ->(word) {where("name LIKE ?", "%#{ word }%")}
  scope :search_task_status, ->(status) {where(status: status)}
end
