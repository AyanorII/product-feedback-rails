class Product < ApplicationRecord
  belongs_to :user

  STATUSES = %i[planned live in_progress suggestion].freeze
  CATEGORIES = %i[ui ux enhancement bug feature].freeze

  enum status: STATUSES
  enum category: CATEGORIES

  validates :title, presence: true
  validates :status, inclusion: { in: STATUSES }
  validates :category, inclusion: { in: CATEGORIES }
end
