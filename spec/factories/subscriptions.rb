FactoryGirl.define do
  factory :subscription, :class => 'HiThere::Subscription' do
    course

    trait :opted_in do
      workflow_state :opted_in
    end

    trait :activated do
      workflow_state :activated
    end
  end
end
