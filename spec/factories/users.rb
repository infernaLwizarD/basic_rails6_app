FactoryBot.define do
  factory :user do
    username { Faker::Internet.unique.username(separators: %w[_]) }
    password { Faker::Internet.password(min_length: 6) }
    role { 'user' }
    confirmed_at { Time.zone.now }
    locked_at { nil }
    email { Faker::Internet.unique.email }

    trait :admin do
      role { 'admin' }
    end

    trait :simple_user do
      role { 'user' }
    end
  end
end
