FactoryBot.define do
  factory :user do
    sequence(:nickname) { |n| "ウォーレン・バフェット#{n}" }
    sequence(:email) { |n| "dammy@example.com#{n}" }
    password {'123456'}
    password_confirmation {'123456'}
    confirmed_at { Time.zone.now }
    confirmation_sent_at { Time.zone.now }
  end
end
