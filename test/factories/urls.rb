FactoryBot.define do
  factory :url do
    long_url { Faker::Internet.url }
    num_clicks { (1..100).to_a.shuffle[0] }
    active { 1 }
  end
end
