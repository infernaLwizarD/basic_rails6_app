FactoryBot.define do
  factory :user do
    username { Faker::Internet.unique.username(separators: %w[_]) }
    password { '1q2w3e4r' }
    role { 'user' }
    confirmed_at { Time.zone.now }
    email { Faker::Internet.unique.email }

    trait :admin do
      role { 'admin' }
    end

    trait :simple_user do
      role { 'user' }
    end
  end
end
