FactoryBot.define do
  factory :guest do
    first_name { "MyString" }
    last_name { "MyString" }
    email { "MyString" }
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
