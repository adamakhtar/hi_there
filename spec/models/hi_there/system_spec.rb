require 'rails_helper'
require 'timecop'

module HiThere
  RSpec.describe "System" do
    it "handles subscription from opt in to completion" do
      course = create(:course)
      email_a = create(:email, subject: 'First email', interval: 1, course: course)
      email_b = create(:email, subject: 'Second email', interval: 1, course: course)
      course.open!

      subscription = CreateSubscription.new(email: 'adam@example.com', course_id: course.id).perform

      expect(ActionMailer::Base.deliveries.size).to eq 1
      expect(ActionMailer::Base.deliveries[0].subject).to eq 'Please confirm your email'

      ActionMailer::Base.deliveries.clear
      ActivateSubscription.new(subscription).perform
      subscription.reload
      
      expect(subscription.next_email).to eq email_a

      Timecop.freeze(25.hours.from_now)
      FulfillSubscriptions.new.perform
      subscription.reload

      expect(subscription.next_email).to eq email_b
      expect(ActionMailer::Base.deliveries.size).to eq 1
      expect(ActionMailer::Base.deliveries[0].subject).to eq 'First email'

      ActionMailer::Base.deliveries.clear
      Timecop.freeze(25.hours.from_now)
      FulfillSubscriptions.new.perform
      subscription.reload

      expect(ActionMailer::Base.deliveries.size).to eq 1
      expect(ActionMailer::Base.deliveries[0].subject).to eq 'Second email'
      expect(subscription.next_email).to eq nil
      expect(subscription.next_email_at).to eq nil
      expect(subscription).to be_completed
    end


    it "unsubscribes people and does not email them anymore" do
      course = create(:course)
      email_a = create(:email, subject: 'First email', interval: 1, course: course)
      email_b = create(:email, subject: 'Second email', interval: 1, course: course)
      course.open!

      subscription = CreateSubscription.new(email: 'adam@example.com', course_id: course.id).perform

      expect(ActionMailer::Base.deliveries.size).to eq 1
      expect(ActionMailer::Base.deliveries[0].subject).to eq 'Please confirm your email'

      ActionMailer::Base.deliveries.clear
      ActivateSubscription.new(subscription).perform
      subscription.reload
      
      expect(subscription.next_email).to eq email_a

      Timecop.freeze(25.hours.from_now)
      FulfillSubscriptions.new.perform
      subscription.reload

      expect(subscription.next_email).to eq email_b
      expect(ActionMailer::Base.deliveries.size).to eq 1
      expect(ActionMailer::Base.deliveries[0].subject).to eq 'First email'

      subscription.unsubscribe!

      ActionMailer::Base.deliveries.clear
      Timecop.freeze(25.hours.from_now)
      FulfillSubscriptions.new.perform
      subscription.reload

      expect(ActionMailer::Base.deliveries.size).to eq 0
    end
  end
end
