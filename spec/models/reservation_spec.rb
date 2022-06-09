require 'rails_helper'

RSpec.describe Reservation, type: :model do
  before :all do
    @guest = create(:guest)
  end

  describe '#calculate_nights_quota' do
    context 'will diff days between end_date and start_date' do
      it 'return 3, if 2022-01-05 diff with 2022-01-02' do
        reservation = create(:reservation, guest: @guest, start_date: '2022-01-02', end_date: '2022-01-05')
        expect(reservation.nights_quota).to eq 3
      end
    end
  end

  describe '#calculate_total_price' do
    context 'will sum between security price and payout_price' do
      it 'return 25, if security price(20) and payout_price(5)' do
        reservation = create(:reservation, guest: @guest, security_price: 20, payout_price: 5)
        expect(reservation.total_price).to eq 25
      end
    end
  end

  describe '#localize_description' do
    context 'will display how many guest string' do
      it 'return "1 guest" if only 1 guest' do
        reservation = create(:reservation,
                             adults_amount: 1, infants_amount: 0, children_amount: 0, guest: @guest)

        expect(reservation.localize_description).to eq "1 guest"
      end

      it 'return "2 guests" if got 2 guests' do
        reservation = create(:reservation,
                             adults_amount: 1, infants_amount: 1, children_amount: 0, guest: @guest)

        expect(reservation.localize_description).to eq "2 guests"
      end
    end
  end

  describe '#guests' do
    context 'will sum among adults_amount, infants_amount and children_amount' do
      it 'return 4, if adults_amount(2), infants_amount(1) and children_amount(1)' do
        reservation = create(:reservation,
                             adults_amount: 2, infants_amount: 1, children_amount: 1, guest: @guest)

        expect(reservation.guests).to eq 4
      end
    end
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
