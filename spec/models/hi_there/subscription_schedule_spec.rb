require 'rails_helper'

module HiThere
  RSpec.describe SubscriptionSchedule, type: :model do
    describe "#advance" do
      context "with more emails to go" do
        it "sets the next email to deliver" do
          course = create(:course)
          email_a = create(:email, subject: 'email_a', interval: 1, course: course)
          email_b = create(:email, subject: 'email_b', interval: 1, course: course)
          subscription = create(:subscription, :confirmed, course: course)
          schedule = SubscriptionSchedule.new(subscription)
          schedule.start

          schedule.advance
          subscription.reload

          expect(subscription.next_issue_number).to eq 2
          expect(subscription.next_delivery_at).to be_within(5.seconds).of(email_a.interval.days.from_now + email_b.interval.days)
        end
      end

      context "when reached end of course" do
        it "sets the subscription as completed" do
          course = create(:course)
          email_a = create(:email, subject: 'email_a', interval: 1, course: course)
          subscription = create(:subscription, :confirmed, course: course)
          schedule = SubscriptionSchedule.new(subscription)
          schedule.start

          schedule.advance
          subscription.reload

          expect(subscription.next_issue_number).to eq nil
          expect(subscription.next_delivery_at).to eq nil
          expect(subscription.current_state).to eq :completed
        end
      end
    end

    describe "#current_issue" do
      it "returns the email due for delivery" do
        course = create(:course)
        email_a = create(:email, subject: 'email_a', interval: 1, course: course)
        email_b = create(:email, subject: 'email_b', interval: 1, course: course)
        subscription = create(:subscription, :confirmed, course: course)
        schedule = SubscriptionSchedule.new(subscription)
        schedule.start

        due = schedule.current_issue

        expect(due).to eq email_a
      end
    end

    describe "#start" do
      it "sets the subscription to the first email of the course" do
        course = create(:course)
        first_interval = 3
        email_a = create(:email, subject: 'email_a', interval: first_interval, course: course)
        
        subscription = create(:subscription, :confirmed, course: course)
        schedule = SubscriptionSchedule.new(subscription)        
        
        result = schedule.start
        subscription.reload

        expect(result).to be_truthy
        expect(subscription.next_issue_number).to eq email_a.issue_number
        expect(subscription.next_delivery_at).to be_within(5.seconds).of(Time.current + first_interval.days)
        expect(subscription.current_state).to eq :activated
      end
    end
  end
end
