module GuestTranslator
  class SecondPayload < GuestTranslator::Base

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
