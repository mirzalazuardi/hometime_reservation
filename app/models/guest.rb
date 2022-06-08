class Guest < ApplicationRecord
  has_many :reservations, dependent: :destroy
  has_many :guest_phones, dependent: :destroy

  validates_uniqueness_of :email
  accepts_nested_attributes_for :guest_phones, allow_destroy: true, reject_if: proc { |obj| obj.blank? }
end

# == Schema Information
#
# Table name: guests
#
#  id         :bigint           not null, primary key
#  email      :string
#  first_name :string
#  last_name  :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_guests_on_email  (email) UNIQUE
#
