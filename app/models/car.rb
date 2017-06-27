class Car < ApplicationRecord
  belongs_to :user
  validates :registration, :user, presence: true
end
