class ReservationTranslator::FirstPayload
  attr_reader :attrs

  def initialize(reservation_hash)
    @attrs = reservation_hash.with_indifferent_access
  end

  def self.sorted_all_keys
    arr = %w(reservation_code start_date end_date nights)
    arr << %w(guests adults children infants status)
    arr << %w(guest currency payout_price security_price)
    arr << %w(total_price)
    arr.sort
  end

  def self.sorted_accepted_keys
    sorted_all_keys
  end

  def self.sorted_accepted_subkeys
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
    attrs[:adults].to_i
  end

  def children_amount
    attrs[:children].to_i
  end

  def code
    attrs[:reservation_code]
  end

  def currency
    attrs[:currency].upcase
  end

  def end_date
    attrs[:end_date].to_date
  end

  def infants_amount
    attrs[:infants].to_i
  end

  def nights_quota
    attrs[:nights].to_i
  end

  def payout_price
    attrs[:payout_price].to_f
  end

  def security_price
    attrs[:security_price].to_f
  end

  def start_date
    attrs[:start_date].to_date
  end

  def status
    attrs[:status]
  end

  def total_price
    (payout_price + security_price).to_f
  end

  def guest
    GuestTranslator.new(attrs).call
  end
end
