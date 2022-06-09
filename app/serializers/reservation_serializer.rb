class ReservationSerializer
  include FastJsonapi::ObjectSerializer

  belongs_to :guest
  attributes *Reservation.column_names.map(&:to_sym)

  attribute :guest_attributes do |object, params|
    params[:guest_columns]&.size&.positive? ? object.guest.slice(*params[:guest_columns]) : object.guest
  end
end
