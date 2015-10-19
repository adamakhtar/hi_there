require 'rails_helper'
require 'timecop'

module HiThere
  RSpec.describe ActivateSubscription, type: :operation do
    describe "#perform" do
      context "when valid subscription" do
        it "is success" do
          course = create(:course, :opened, deliver_at: "09:30")
          email_a = create(:email, interval: 2, course: course)
          subscription = create(:subscription, :opted_in, course: course)        
          operation = ActivateSubscription.new(subscription)
          current_time = DateTime.parse("07:00")
          Timecop.travel(current_time)

          result = operation.perform
          subscription.reload

          expected_deliver_at = (current_time + 2.days).change(hour: 9, min: 30)
          expect(result).to be_truthy
          expect(subscription.next_email).to eq email_a
          expect(subscription.next_email_at).to be_within(5.seconds).of(expected_deliver_at)
        end
      end
    end
  end
end
