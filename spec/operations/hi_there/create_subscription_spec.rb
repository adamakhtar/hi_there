require 'rails_helper'

module HiThere
  RSpec.describe CreateSubscription, type: :operation do
    describe "#perform" do
      context "when course opened" do
        it "is success" do
          course = create(:course, :opened)          
          operation = CreateSubscription.new(email: "adam@example.com", course_id: course.id)

          subscription = operation.perform

          expect(subscription).to be_valid
          expect(subscription.email).to eq "adam@example.com"
          expect(subscription.course_id).to eq course.id
        end
      end
    end
  end
end
