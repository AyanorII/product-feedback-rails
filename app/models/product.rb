class Product < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy

  STATUSES = %i[planned live in_progress suggestion].freeze
  CATEGORIES = %i[ui ux enhancement bug feature].freeze

  enum status: STATUSES
  enum category: CATEGORIES

  validates :title, presence: true
  validates :status, inclusion: { in: statuses.keys }
  validates :category, inclusion: { in: categories.keys }
end
