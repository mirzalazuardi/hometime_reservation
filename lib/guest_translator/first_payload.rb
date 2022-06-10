module GuestTranslator
  class FirstPayload < GuestTranslator::Base

    def email
      attrs['guest']['email']
    end

    def first_name
      attrs['guest']['first_name']
    end

    def last_name
      attrs['guest']['last_name']
    end

    def guest_phones
      [
        {number: attrs['guest']['phone']}
      ]
    end
  end
end
