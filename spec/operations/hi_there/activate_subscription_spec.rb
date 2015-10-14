require 'rails_helper'

module HiThere
  RSpec.describe ActivateSubscription, type: :operation do
    describe "#perform" do
      context "when valid subscription" do
        it "is success" do
          course = create(:course, :opened)
          email_a = create(:email, interval: 2, course: course)
          subscription = create(:subscription, :opted_in, course: course)        
          operation = ActivateSubscription.new(subscription)

          result = operation.perform
          subscription.reload

          expect(result).to be_truthy
          expect(subscription.next_email).to eq email_a
          expect(subscription.next_email_at).to be_within(5.seconds).of(email_a.due_from_now)
        end
      end
    end
  end
end
