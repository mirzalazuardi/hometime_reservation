class Reservation < ApplicationRecord
  belongs_to :guest
  validates_uniqueness_of :code

  accepts_nested_attributes_for :guest, allow_destroy: true, reject_if: proc { |obj| obj.blank? }
end

# == Schema Information
#
# Table name: reservations
#
#  id              :bigint           not null, primary key
#  adults_amount   :integer
#  children_amount :integer
#  code            :string
#  currency        :string
#  end_date        :date
#  infants_amount  :integer
#  nights_quota    :integer
#  payout_price    :decimal(8, 2)
#  security_price  :decimal(8, 2)
#  start_date      :date
#  status          :string
#  total_price     :decimal(8, 2)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  guest_id        :bigint           not null
#
# Indexes
#
#  index_reservations_on_code      (code) UNIQUE
#  index_reservations_on_guest_id  (guest_id)
#
# Foreign Keys
#
#  fk_rails_...  (guest_id => guests.id)
#
