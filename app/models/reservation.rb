class Reservation < ApplicationRecord
  include Serializable

  belongs_to :guest

  validates :start_date, :end_date,
    format: { with: /20\d{2}-[0-1]\d{1}-[0-3]\d{1}/ }
  validates_uniqueness_of :code
  validates :adults_amount, :infants_amount, :children_amount,
    numericality: { only_integer: true }
  validates :payout_price, :security_price, numericality: true
  validates :adults_amount, :children_amount, :code, :currency,
    :end_date, :infants_amount, :payout_price,
    :security_price, :start_date, :status, presence: true
  validate :start_date_validator
  validate :end_date_validator
  validate :end_date_greater_validator

  accepts_nested_attributes_for :guest, allow_destroy: true, reject_if: proc { |obj| obj.blank? }

  before_save :calculate_total_price
  before_save :calculate_nights_quota

  #validations
  def self.is_valid_date?(date_str)
    !((Date.parse(date_str) rescue ArgumentError) == ArgumentError)
  end

  def start_date_validator
    errors.add(:start_date, 'invalid date') unless self.class.is_valid_date?(start_date.to_s)
  end

  def end_date_validator
    errors.add(:end_date, 'invalid date') unless self.class.is_valid_date?(end_date.to_s)
  end

  def end_date_greater_validator
    return if !self.class.is_valid_date?(start_date.to_s) or !self.class.is_valid_date?(end_date.to_s)
    errors.add(:end_date, 'end date must after start date') if end_date < start_date
  end
  #end of validations

  def calculate_nights_quota
    unwanted_state = !self.class.is_valid_date?(start_date.to_s) or !self.class.is_valid_date?(end_date.to_s)
    raise ArgumentError if unwanted_state

    self.nights_quota = (end_date - start_date).to_i
  end

  def calculate_total_price
    self.total_price = self.security_price + self.payout_price
  end

  def nights
    nights_quota
  end

  def adults
    adults_amount
  end

  def children
    children_amount
  end

  def infants
    infants_amount
  end

  def guests
    adults + children + infants
  end
  alias guests_amount guests

  def localize_description
    "#{guests} #{'guest'.pluralize(guests)}"
  end

  ##class methods
  def self.translator_klass(params)
    return ::ReservationTranslator::SecondPayload if params.keys.include?('reservation')
    ::ReservationTranslator::FirstPayload
  end

  def self.is_valid_payload?(params)
    params = params.as_json.with_indifferent_access.except(:format, :controller, :action)

    first_type_check = (params&.keys&.sort&.map(&:to_s) == first_payload_keys || params&.dig(:guest)&.keys&.sort&.map(&:to_s) == first_payload_keys(level: 1))
    second_type_check = (params&.keys&.sort&.map(&:to_s) == second_payload_keys && params.dig(:reservation)&.keys&.sort&.map(&:to_s) == second_payload_keys(level: 1) && params&.dig(:reservation, :guest_details)&.keys&.sort&.map(&:to_s) == second_payload_keys(level: 2))

    first_type_check || second_type_check
  end

  def self.first_payload_keys(type: nil, level: nil)
    if type == :root || level == 0 || (type == nil && level == nil)
      %w(reservation_code start_date end_date nights
         guests adults children infants status guest
         currency payout_price security_price total_price).sort
    elsif type == :guest || level == 1
      %w(first_name last_name phone email).sort
    end
  end

  def self.second_payload_keys(type: nil, level: nil)
    if type == :root || level == 0 || (type == nil && level == nil)
      %w(reservation)
    elsif type == :reservation || level == 1
      %w(code start_date end_date expected_payout_amount
      guest_details guest_email guest_first_name guest_last_name
      guest_phone_numbers listing_security_price_accurate
      host_currency nights number_of_guests status_type total_paid_amount_accurate).sort
    elsif type == :guest_details || level == 2
      %w(localized_description number_of_adults number_of_children number_of_infants).sort
    end
  end
end

# == Schema Information
#
# Table name: reservations
#
#  id              :bigint           not null, primary key
#  adults_amount   :integer
#  children_amount :integer
#  code            :string
#  currency        :string
#  end_date        :date
#  infants_amount  :integer
#  nights_quota    :integer
#  payout_price    :decimal(8, 2)
#  security_price  :decimal(8, 2)
#  start_date      :date
#  status          :string
#  total_price     :decimal(8, 2)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  guest_id        :bigint           not null
#
# Indexes
#
#  index_reservations_on_code      (code) UNIQUE
#  index_reservations_on_guest_id  (guest_id)
#
# Foreign Keys
#
#  fk_rails_...  (guest_id => guests.id)
#
