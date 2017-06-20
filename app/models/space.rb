class Space < ApplicationRecord
  belongs_to :user

  validates :name, :location, :user_id, :price, presence: true

  geocoded_by :location
  after_validation :geocode, if: :location_changed?
end
