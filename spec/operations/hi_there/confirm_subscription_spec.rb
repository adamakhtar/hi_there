require 'rails_helper'

module HiThere
  RSpec.describe ConfirmSubscription, type: :operation do
    describe "#perform" do
      context "when valid subscription" do
        it "is success" do
          subscription = double(:subscription, confirm!: nil)
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
