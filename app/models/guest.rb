class Guest < ApplicationRecord
  has_many :reservations
  has_many :guest_phones

  validates_uniqueness_of :email
end
