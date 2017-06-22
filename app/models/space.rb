class Space < ApplicationRecord
  belongs_to :user

  validates :name, :location, :user_id, :price, presence: true

  geocoded_by :location
  after_validation :geocode, if: :location_changed?

  has_many :reviews, dependent: :destroy

  has_attachment :photo

  monetize :price_cents

  def rating
    self.reviews.empty? ? 0 : self.reviews.average(:rating).round
  end
end
