FactoryGirl.define do
  factory :subscription, :class => 'HiThere::Subscription' do
    email "adam@example.com"
    course

    trait :confirmed do
      workflow_state :confirmed
    end
  end
end
