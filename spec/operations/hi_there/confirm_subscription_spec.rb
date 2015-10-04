require 'rails_helper'

module HiThere
  RSpec.describe ConfirmSubscription, type: :operation do
    describe "#perform" do
      context "when valid subscription" do
        it "is success" do
          course = double(:course, opened?: true)
          subscription = double(:subscription, activate!: nil, course: course)
          schedule = double(:schedule, start: true)
          allow(SubscriptionSchedule).to receive(:new).with(subscription).and_return(schedule)
          operation = ConfirmSubscription.new(subscription)

          result = operation.perform

          expect(result).to be_truthy
        end
      end
    end
  end
end
