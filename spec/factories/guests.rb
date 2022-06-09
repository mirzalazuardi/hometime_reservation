FactoryBot.define do
  factory :guest do
    first_name { Faker::Name.unique.first_name }
    last_name { Faker::Name.unique.last_name }
    email { "#{first_name.downcase}_#{last_name.downcase}@mail.com" }
  end
end

# == Schema Information
#
# Table name: guests
#
#  id         :bigint           not null, primary key
#  email      :string
#  first_name :string
#  last_name  :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_guests_on_email  (email)
#
