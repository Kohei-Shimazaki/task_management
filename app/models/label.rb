class Label < ApplicationRecord
  has_many :labelings, dependent: :destroy
  has_many :tasks, through: :labelings, source: :task
  belongs_to :user
  enum color: %i[green blue red orange]
  enum shape: %i[ellipse square arrow]
  validates :title, presence: true, length: {maximum: 15}
end
