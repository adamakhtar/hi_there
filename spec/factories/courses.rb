FactoryGirl.define do
  factory :course, class: 'HiThere::Course' do
    sequence(:title){|x| "#{x} ways to get rich"}
    sequence(:name){|x| "#{x}_course"}

    trait :opened do
      workflow_state 'opened'
    end

    trait :draft do
      workflow_state 'draft'
    end

    trait :closed do
      workflow_state 'draft'
    end
  end 
end
