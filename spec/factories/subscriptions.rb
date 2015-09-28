FactoryGirl.define do
  factory :subscription, :class => 'HiThere::Subscription' do
    email "adam@example.com"
    course
  end
end
