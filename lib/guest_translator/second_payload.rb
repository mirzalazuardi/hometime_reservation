module GuestTranslator
  class SecondPayload
    attr_reader :attrs

    def initialize(reservation_hash)
      @attrs = reservation_hash
    end

    def self.sorted_keys
      arr = %w(guest_details guest_email guest_first_name)
      arr << %w(guest_last_name guest_phone_numbers)
      arr.sort
    end

    def self.sorted_subkeys
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
      attrs[:guest_email]
    end

    def first_name
      attrs[:guest_first_name]
    end

    def last_name
      attrs[:guest_last_name]
    end

    def guest_phones
      attrs[:guest_phone_numbers].map do |number|
        {number: number}
      end
    end
  end
end
