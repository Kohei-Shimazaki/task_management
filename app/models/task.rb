class Task < ApplicationRecord
  belongs_to :user
  has_many :labelings, dependent: :destroy
  has_many :labels, through: :labelings, source: :label

  validates :name, presence: true, length: {maximum: 30}
  validates :content, presence: true
  enum priority: %i[low middle high]

  scope :search_like_name, ->(word) {where("name LIKE ?", "%#{ word }%")}
  scope :search_status, ->(status) {where(status: status)}
  scope :order_deadline, -> {order(deadline: :desc)}
  scope :order_priority, -> {order(priority: :desc)}
  scope :order_created_at, -> {order(created_at: :desc)}
end
