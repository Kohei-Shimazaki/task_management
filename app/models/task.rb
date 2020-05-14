class Task < ApplicationRecord
  validates :name, presence: true, length: {maximum: 30}
  validates :content, presence: true
  enum priority: [:低, :中, :高]

  belongs_to :user
  has_many :labelings, dependent: :destroy, inverse_of: :task
  accepts_nested_attributes_for :labelings, allow_destroy: true, reject_if: :all_blank
  has_many :labels, through: :lagbellings, source: :label

  scope :search_like_name, ->(word) {where("name LIKE ?", "%#{ word }%")}
  scope :search_status, ->(status) {where(status: status)}
  scope :order_deadline, -> {order(deadline: :desc)}
  scope :order_priority, -> {order(priority: :desc)}
  scope :order_created_at, -> {order(created_at: :desc)}
end
