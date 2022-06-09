include   ActionView::Helpers::DateHelper


FactoryBot.define do
  factory :reservation do
    code { SecureRandom.hex(5) }
    start_date { '2022-01-01' }
    end_date { '2022-01-10' }
    adults_amount { rand(10) }
    children_amount { rand(10) }
    infants_amount { rand(10) }
    status { "accepted" }
    currency { "AUD" }
    security_price { "10.00" }
    payout_price { "5.00" }
  end
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
