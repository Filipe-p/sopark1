class Space < ApplicationRecord
  searchkick locations: [:location]
  belongs_to :user

  validates :name, :location, :price, presence: true
  validates :name, uniqueness: :true

  geocoded_by :location
  after_validation :geocode, if: :location_changed?

  has_many :reviews, dependent: :destroy
  has_many :bookings, dependent: :destroy

  has_attachment :photo

  monetize :price_cents

  def rating
    self.reviews.empty? ? 0 : self.reviews.average(:rating).round
  end

  # See if space offering is past date
  # Select the availability
  # Check if dates are available

  def booking_dates
    result = []
    self.bookings.each do |booking|
      if booking.state == "paid"
        demand = (booking.start_datetime..booking.end_datetime).to_a
        result += demand
      end
    end
    result
  end


  def reserved_dates
    result = []
    self.bookings.each do |booking|
      if booking.state == "reserved"
        reserved = (booking.start_datetime..booking.end_datetime).to_a
        result +=  reserved
      end
    end
    result
  end

  def unavailable_dates
    (booking_dates + reserved_dates).uniq.sort
  end

  def available?(booking)
    unavailable_dates - (booking.start_datetime..booking.end_datetime).to_a == unavailable_dates
  end

  def search_data
   attributes.merge location: {lat: latitude, lon: longitude}
  end

end
