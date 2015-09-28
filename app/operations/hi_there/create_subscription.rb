module HiThere
  class CreateSubscription
    def initialize(params={})
      @params = params
    end

    def perform
      course = find_opened_course
      subscription = create_subscription(course)          
      subscription
    end

    private

    attr_reader :params

    def find_opened_course
      Course.with_opened_state.find(params[:course_id])
    end

    def create_subscription(course)
      Subscription.create(email: params[:email], course: course)
    end
  end
end