FactoryGirl.define do
  factory :course, class: 'HiThere::Course' do
    sequence(:title){|x| "#{x} ways to get rich"}
  end
end
