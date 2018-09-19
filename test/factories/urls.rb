FactoryBot.define do
  factory :url do
    user_slug { RandomString.generate }
    admin_slug { RandomString.generate }
    long_url { Faker::Internet.url }
    num_clicks { (1..100).to_a.shuffle[0] }
  end
end
