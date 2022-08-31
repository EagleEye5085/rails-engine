FactoryBot.define do
  factory :item do
    name { Faker::Name.name }
    description { Faker::Food.description }
    unit_price { Faker::Number.decimal }
  end
end
