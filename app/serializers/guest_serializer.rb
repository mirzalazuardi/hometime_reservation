class GuestSerializer
  include JSONAPI::Serializer
  attributes :email, :first_name, :last_name
  has_many :guest_phones

  attributes :email, :first_name, :last_name
end
