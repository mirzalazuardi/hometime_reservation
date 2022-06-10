module GuestTranslator
  class SecondPayload
    attr_reader :attrs

    def initialize(reservation_hash)
      @attrs = reservation_hash
    end

    def call
      {
        email: email,
        first_name: first_name,
        last_name: last_name,
        guest_phones_attributes: guest_phones
      }
    end

    def email
      attrs['reservation']['guest_email']
    end

    def first_name
      attrs['reservation']['guest_first_name']
    end

    def last_name
      attrs['reservation']['guest_last_name']
    end

    def guest_phones
      attrs['reservation']['guest_phone_numbers'].map do |number|
        {'number' => number}
      end
    end
  end
end
