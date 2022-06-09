class GuestPhoneSerializer
  include JSONAPI::Serializer
  attributes :number, :guest_id, :created_at, :updated_at
end

# == Schema Information
#
# Table name: guest_phones
#
#  id         :bigint           not null, primary key
#  number     :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  guest_id   :bigint           not null
#
# Indexes
#
#  index_guest_phones_on_guest_id  (guest_id)
#
# Foreign Keys
#
#  fk_rails_...  (guest_id => guests.id)
#
