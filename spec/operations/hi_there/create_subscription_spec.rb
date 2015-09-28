require 'rails_helper'

module HiThere
  RSpec.describe CreateSubscription, type: :operation do
    describe "#perform" do
      context "when course opened" do
        it "is success" do
          subscription = double(:subscription)
          course = create(:course, :opened)
          operation = CreateSubscription.new(email: "adam@example.com", course_id: course.id)
          allow(Subscription).to receive(:create).with(email: "adam@example.com", course: course).and_return(subscription)
  
          sub = operation.perform

          expect(sub).to eq subscription
        end
      end
    end
  end
end
