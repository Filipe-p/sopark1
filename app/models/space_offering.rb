class SpaceOffering < ApplicationRecord
  belongs_to :user
  belongs_to :space

  monetize :price_cents

  validates :user, :price, :start_datetime, :end_datetime, presence: true
end
