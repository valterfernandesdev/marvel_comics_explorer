FactoryBot.define do
  factory :favourit_comic do
    comic_id { Faker::Number.number(digits: 1).to_i }
    user_id { Faker::Internet.uuid }
  end
end