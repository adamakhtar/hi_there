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
        end
      end
    end
  end
end
