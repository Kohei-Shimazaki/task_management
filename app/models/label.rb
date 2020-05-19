class Label < ApplicationRecord
  has_many :labelings, dependent: :destroy
  has_many :tasks, through: :labelings, source: :task
  belongs_to :user
  enum color: [:緑, :青, :赤, :オレンジ]
  enum shape: [:楕円, :四角, :矢印]
  validates :title, presence: true, length: {maximum: 15}
end
