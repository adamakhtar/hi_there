module HiThere
  class TerminateCourse
    def initialize(course)
      @course = course
    end

    def perform
      if course.terminate! and course.subscriptions.update_all(workflow_state: :terminated)
        true
      else
        false
      end
    end

    private

    attr_reader :course
  end
end