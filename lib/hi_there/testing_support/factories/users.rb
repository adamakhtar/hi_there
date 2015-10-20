FactoryGirl.define do
  factory :user do
    password 'password'
    password_confirmation 'password'
    sequence(:email){ |x| "me-#{x}@example.com" }

    factory :admin do
      admin true
    end
  end
end
