class GuestPhoneSerializer
  include JSONAPI::Serializer
  attributes :number, :guest_id, :created_at, :updated_at
end
