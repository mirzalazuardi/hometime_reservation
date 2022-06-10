module ReservationTranslator
  class SecondPayload < ReservationTranslator::Base

    def adults_amount
      attrs['reservation']['guest_details']['number_of_adults']
    end

    def children_amount
      attrs['reservation']['guest_details']['number_of_children']
    end

    def code
      attrs['reservation']['code']
    end

    def currency
      attrs['reservation']['host_currency']
    end

    def end_date
      attrs['reservation']['end_date']#.to_date
    end

    def infants_amount
      attrs['reservation']['guest_details']['number_of_infants']
    end

    def nights_quota
      attrs['reservation']['nights']#.to_i
    end

    def payout_price
      attrs['reservation']['expected_payout_amount']
    end

    def security_price
      attrs['reservation']['listing_security_price_accurate']
    end

    def start_date
      attrs['reservation']['start_date']#.to_date
    end

    def status
      attrs['reservation']['status_type']
    end

    def guest
      GuestTranslator::SecondPayload.new(attrs).call
    end
  end
end
