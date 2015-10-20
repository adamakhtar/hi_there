FactoryGirl.define do
  factory :subscription, :class => 'HiThere::Subscription' do
    subscriber
    course

    trait :opted_in do
      workflow_state :opted_in
    end

    trait :activated do
      workflow_state :activated
      activated_at 3.days.ago
    end

    trait :completed do
      workflow_state :completed
    end

    trait :unsubscribed do
      workflow_state :unsubscribed
      unsubscribed_at 1.day.ago
    end
  end
end
