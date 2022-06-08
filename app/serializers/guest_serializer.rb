class GuestSerializer
  include JSONAPI::Serializer
  has_many :guest_phones

  attributes :email, :first_name, :last_name, :created_at, :updated_at
end
