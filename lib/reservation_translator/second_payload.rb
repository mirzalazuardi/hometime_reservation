module ReservationTranslator
  class SecondPayload < ReservationTranslator::Base

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
