module GuestTranslator
  class Base
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
  end
end
