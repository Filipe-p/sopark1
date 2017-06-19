class Car < ApplicationRecord
  belongs_to :user
  validates :registration, :user_id, presence: true
end
