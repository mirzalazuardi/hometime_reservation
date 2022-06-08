FactoryBot.define do
  factory :reservation do
    code { "MyString" }
    guest { nil }
    start_date { "2022-06-08" }
    end_date { "2022-06-08" }
    nights_quota { 1 }
    adults_amount { 1 }
    children_amount { 1 }
    infants_amount { 1 }
    status { "MyString" }
    currency { "MyString" }
    security_price { "9.99" }
    payout_price { "9.99" }
    total_price { "9.99" }
  end
end
