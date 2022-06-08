class Guest < ApplicationRecord
  validates_uniqueness_of :email
end
