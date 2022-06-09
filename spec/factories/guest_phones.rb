FactoryBot.define do
  factory :guest_phone do
    number { Faker::PhoneNumber.unique.cell_phone_in_e164 }
  end
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
