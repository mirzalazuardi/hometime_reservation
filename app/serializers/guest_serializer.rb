class GuestSerializer
  include JSONAPI::Serializer
  attributes :email, :first_name, :last_name
end
