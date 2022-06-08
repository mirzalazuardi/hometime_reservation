class GuestTranslator::FirstPayload
  attr_reader :attrs

  def initialize(reservation_hash)
    @attrs = reservation_hash.with_indifferent_access
  end

  def self.sorted_accepted_keys
    %w(guest)
  end

  def self.sorted_accepted_subkeys
    [
      {
        guest: %w(first_name last_name phone email).sort
      }.with_indifferent_access
    ]
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
    attrs[:guest][:email]
  end

  def first_name
    attrs[:guest][:first_name]
  end

  def last_name
    attrs[:guest][:last_name]
  end

  def guest_phones
    attrs[:guest][:phone]
  end
end
