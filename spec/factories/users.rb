FactoryBot.define do
  factory :user do
    sequence(:nickname) { |n| "ウォーレン・バフェット#{n}" }
    sequence(:email) { |n| "dammy@example.com#{n}" }
    password {'1234azAZ'}
    password_confirmation {'1234azAZ'}
    confirmed_at { Time.zone.now }
    confirmation_sent_at { Time.zone.now }
  end
end
