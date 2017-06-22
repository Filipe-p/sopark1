class Review < ApplicationRecord

  belongs_to :user
  belongs_to :space

  validates :content, :rating, presence: true
  validates :rating, numericality: { only_integer: true }
  validates :rating, inclusion: { in: (0..5), allow_nil: false }
end
