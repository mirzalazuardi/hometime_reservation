module ReservationTranslator
  class FirstPayload < ReservationTranslator::Base

    def adults_amount
      attrs[:adults]
    end

    def children_amount
      attrs[:children]
    end

    def code
      attrs[:reservation_code]
    end

    def currency
      attrs[:currency].upcase
    end

    def end_date
      attrs[:end_date]#.to_date
    end

    def infants_amount
      require 'pry'; binding.pry
      attrs[:infants]
    end

    def nights_quota
      attrs[:nights]
    end

    def payout_price
      attrs[:payout_price]
    end

    def security_price
      attrs[:security_price]
    end

    def start_date
      attrs[:start_date]#.to_date
    end

    def status
      attrs[:status]
    end

    def guest
      GuestTranslator::FirstPayload.new(attrs).call
    end
  end
end
