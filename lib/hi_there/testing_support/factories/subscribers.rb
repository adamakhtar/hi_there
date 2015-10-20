FactoryGirl.define do
  factory :subscriber, :class => 'HiThere::Subscriber' do
    sequence(:email){ |x| "adam#{x}@example.com"}
  end
end
