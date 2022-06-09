module ReservationTranslator
  class SecondPayload
    attr_reader :attrs

    def initialize(reservation_hash = {})
      @attrs = reservation_hash[:reservation]
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
        guest_attributes: guest
      }
    end

    def adults_amount
      attrs[:guest_details][:number_of_adults]
    end

    def children_amount
      attrs[:guest_details][:number_of_children]
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
      attrs[:guest_details][:number_of_infants]
    end

    def nights_quota
      attrs[:nights].to_i
    end

    def payout_price
      attrs[:expected_payout_amount]
    end

    def security_price
      attrs[:listing_security_price_accurate]
    end

    def start_date
      attrs[:start_date]#.to_date
    end

    def status
      attrs[:status_type]
    end

    def guest
      GuestTranslator::SecondPayload.new(attrs).call
    end
  end
end

#hash = {
#"reservation": {
  #"code": "XXX12345678",
  #"start_date": "2021-03-12",
  #"end_date": "2021-03-16",
  #"expected_payout_amount": "3800.00",
  #"guest_details": {
  #"localized_description": "4 guests",
  #"number_of_adults": 2,
  #"number_of_children": 2,
  #"number_of_infants": 0
  #},
  #"guest_email": "wayne_woodbridge@bnb.com",
  #"guest_first_name": "Wayne",
  #"guest_last_name": "Woodbridge",
  #"guest_phone_numbers": [ "639123456789", "639123456789" ],
  #"listing_security_price_accurate": "500.00",
  #"host_currency": "AUD",
  #"nights": 4,
  #"number_of_guests": 4,
  #"status_type": "accepted",
  #"total_paid_amount_accurate": "4300.00"
  #}
#}

#puts ReservationTranslator::SecondPayload.new(hash).call.inspect
