require 'rails_helper'

module HiThere
  RSpec.describe CreateSubscription, type: :operation do
    describe "#perform" do
      context "when course opened" do
        it "is success" do
          subscription = double(:subscription)
          course = build_stubbed(:course, workflow_state: 'opened')
          operation = CreateSubscription.new(email: "adam@example.com", course_id: course.id)
          allow(operation).to receive(:create_subscription).and_return(subscription)
          allow(Course).to receive(:find).and_return course

          sub = operation.perform

          expect(sub).to eq subscription
        end
      end
    end
  end
end
