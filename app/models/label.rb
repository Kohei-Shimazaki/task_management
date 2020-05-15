class Label < ApplicationRecord
  validates :title, presence: true, length: {maximum: 15}
  enum color: [:緑, :青, :赤, :オレンジ]
  enum shape: [:楕円, :四角, :矢印]
  has_many :labelings, dependent: :destroy
  has_many :tasks, through: :labelings, source: :task
  belongs_to :user
end
