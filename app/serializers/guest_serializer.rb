class GuestSerializer
  include FastJsonapi::ObjectSerializer
  has_many :guest_phones

  attributes :email, :first_name, :last_name, :created_at, :updated_at
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
