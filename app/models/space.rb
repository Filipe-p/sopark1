class Space < ApplicationRecord
  belongs_to :user

  validates :name, :location, :user_id, presence: true

  geocoded_by :address
  after_validation :geocode, if: :address_changed?
end
