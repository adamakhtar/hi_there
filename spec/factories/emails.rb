FactoryGirl.define do
  factory :email, :class => 'HiThere::Email' do
    sequence(:subject){|x| "Part #{x} - How to lose weight"}
    body "blah blah blah"
    course
    interval 1
  end
end
