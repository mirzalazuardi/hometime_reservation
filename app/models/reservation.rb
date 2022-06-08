class Reservation < ApplicationRecord
  belongs_to :guest
  validates_uniqueness_of :code
end
