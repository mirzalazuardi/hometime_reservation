module ReservationTranslator
  class Base
    attr_reader :attrs

    def initialize(reservation_hash = {})
      @attrs = reservation_hash[:reservation].present? ? reservation_hash[:reservation] : reservation
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
  end
end
