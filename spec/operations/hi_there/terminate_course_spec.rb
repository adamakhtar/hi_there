require 'rails_helper'

module HiThere
  RSpec.describe TerminateCourse, type: :operation do
    describe "#perform" do
      it "sets course and subscriptions state to terminated" do      
        course = create(:course, :opened)
        subscription = create(:subscription, :activated, course: course)
        operation = TerminateCourse.new(course)

        result = operation.perform
        subscription.reload
        course.reload

        expect(result).to be_truthy
        expect(course.terminated?).to be_truthy
        expect(subscription.terminated?).to be_truthy
      end
    end
  end
end
