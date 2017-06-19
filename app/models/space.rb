class Space < ApplicationRecord
  belongs_to :user

  validates :name, :location, :user_id, presence: true
end
