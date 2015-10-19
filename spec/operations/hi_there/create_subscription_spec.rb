require 'rails_helper'

module HiThere
  RSpec.describe CreateSubscription, type: :operation do
    describe "#perform" do
      context "when course opened" do
        it "is success when valid" do
          course = create(:course, :opened)          
          mailer = double(:mailer, deliver_later: true)
          allow(SubscriptionMailer).to receive(:confirm_your_email).and_return(mailer)
          operation = CreateSubscription.new(email: "adam@example.com", course_id: course.id)

          subscription = operation.perform

          expect(subscription).to be_valid
          expect(subscription.current_state).to eq 'opted_in'
          expect(subscription.subscriber.email).to eq "adam@example.com"
          expect(subscription.course_id).to eq course.id      
        end

        it "does not create records when valid" do
          course = create(:course, :opened)          
          operation = CreateSubscription.new(email: "", course_id: course.id)

          result = operation.perform

          expect(result).to be_falsey
          expect(Subscription.count).to eq 0
          expect(Subscriber.count).to eq 0
        end
      end
    end
  end
end
