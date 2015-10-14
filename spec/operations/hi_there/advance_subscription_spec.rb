require 'rails_helper'

module HiThere
  RSpec.describe AdvanceSubscription, type: :operation do
    describe "#perform" do
      context "when further emails in course" do
        it "sets previous and next email" do
          course = create(:course, :opened)
          email_a = create(:email, interval: 2, course: course)
          email_b = create(:email, interval: 3, course: course)
          subscription = create(:subscription, :activated, course: course, next_email: email_a, next_email_at: 1.second.ago)                  
          operation = AdvanceSubscription.new(subscription)

          result = operation.perform
          subscription.reload

          expect(result).to be_truthy
          expect(subscription.previous_email).to eq email_a
          expect(subscription.next_email).to eq email_b
          expect(subscription.next_email_at).to be_within(5.seconds).of(email_b.due_from_now)
        end
      end

      context "when reached end of course" do
        it "sets the previous email and marks next email as nil" do
          course = create(:course, :opened)
          email_a = create(:email, interval: 2, course: course)
          email_b = create(:email, interval: 3, course: course)
          subscription = create(:subscription, :activated, course: course, previous_email: email_a, next_email: email_b, next_email_at: 1.second.ago)                  
          operation = AdvanceSubscription.new(subscription)

          result = operation.perform
          subscription.reload

          expect(result).to be_truthy
          expect(subscription.previous_email).to eq email_b
          expect(subscription.next_email).to be nil
          expect(subscription.next_email_at).to be nil 
        end
      end

      context "when already completed course" do
        it "does nothing" do
          course = create(:course, :opened)
          email_a = create(:email, interval: 2, course: course)
          subscription = create(:subscription, :activated, course: course, previous_email: email_a, next_email: nil)                  
          operation = AdvanceSubscription.new(subscription)

          result = operation.perform
          subscription.reload

          expect(result).to be_falsey
          expect(subscription.next_email).to be nil
          expect(subscription.next_email_at).to be nil 
        end
      end
    end
  end
end
