FactoryGirl.define do
  factory :hi_there_subscription, :class => 'HiThere::Subscription' do
    email "adam@example.com"
    course
  end
end
