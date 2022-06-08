class ReservationTranslator::FirstPayload
  attattr_reader :attrs

  def initialize(reservation_hash)
    @attrs = reservation_hash.with_indifferent_access
  end

  def self.sorted_keys
    arr = %w(reservation_code start_date end_date nights)
    arr << %w(guests adults children infants status)
    arr << %w(guest currency payout_price security_price)
    arr << %w(total_price)
    arr.sort
  end

  def self.sorted_subkeys
    [
      {
        guest: %w(first_name last_name phone email).sort
      }.with_indifferent_access
    ]
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
      total_price: total_price,
      guest_attributes: guest
    }
  end

  def adults_amount
  end
  def children_amount
  end
  def code
  end
  def currency
  end
  def end_date
  end
  def infants_amount
  end
  def nights_quota
  end
  def payout_price
  end
  def security_price
  end
  def start_date
  end
  def status
  end
  def total_price
  end
  def guest
  end
end
