require_relative './../guest_translator/second_payload.rb'

module ReservationTranslator
  class SecondPayload
    attr_reader :attrs

    def initialize(reservation_hash = {})
      @attrs = reservation_hash[:reservation]
    end

    def self.sorted_all_keys
      arr = %w(code start_date end_date expected_payout_amount)
      arr << %w(guest_details guest_email guest_first_name guest_last_name)
      arr << %w(guest_phone_numbers listing_security_price_accurate)
      arr << %w(host_currency nights number_of_guests status_type)
      arr << %w(total_paid_amount_accurate)
      arr.flatten.sort
    end

    def self.sorted_accepted_keys
      sorted_all_keys
    end

    def self.sorted_accepted_subkeys
      [
        {
          guest_details: %w(number_of_adults number_of_children number_of_infants)
        }
      ]
    end

    def call
      {
        adults_amount: adults_amount,
        children_amount: children_amount,
        code: code,
        currency: currency,
        end_date: end_date,
        infants_amount: infants_amount,
        nights_quota: nights_quota,
        payout_price: payout_price,
        security_price: security_price,
        start_date: start_date,
        status: status,
        total_price: total_price,
        guest_attributes: guest
      }
    end

    def adults_amount
      attrs[:guest_details][:number_of_adults].to_i
    end

    def children_amount
      attrs[:guest_details][:number_of_children].to_i
    end

    def code
      attrs[:code]
    end

    def currency
      attrs[:host_currency].upcase
    end

    def end_date
      attrs[:end_date]#.to_date
    end

    def infants_amount
      attrs[:number_of_infants].to_i
    end

    def nights_quota
      attrs[:nights].to_i
    end

    def payout_price
      attrs[:expected_payout_amount].to_f
    end

    def security_price
      attrs[:listing_security_price_accurate].to_f
    end

    def start_date
      attrs[:start_date]#.to_date
    end

    def status
      attrs[:status_type]
    end

    def total_price
      (payout_price + security_price).to_f
    end

    def guest
      GuestTranslator::SecondPayload.new(attrs).call
    end
  end
end

hash = {
"reservation": {
  "code": "XXX12345678",
  "start_date": "2021-03-12",
  "end_date": "2021-03-16",
  "expected_payout_amount": "3800.00",
  "guest_details": {
  "localized_description": "4 guests",
  "number_of_adults": 2,
  "number_of_children": 2,
  "number_of_infants": 0
  },
  "guest_email": "wayne_woodbridge@bnb.com",
  "guest_first_name": "Wayne",
  "guest_last_name": "Woodbridge",
  "guest_phone_numbers": [ "639123456789", "639123456789" ],
  "listing_security_price_accurate": "500.00",
  "host_currency": "AUD",
  "nights": 4,
  "number_of_guests": 4,
  "status_type": "accepted",
  "total_paid_amount_accurate": "4300.00"
  }
}

puts ReservationTranslator::SecondPayload.new(hash).call.inspect
