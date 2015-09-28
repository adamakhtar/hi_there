module HiThere
  class CreateSubscription
    def initialize(params={})
      @params = params
    end

    def perform
      with_open_course do |course|
        create_subscription(course)          
      end
    end

    private

    attr_reader :params

    def with_open_course
      course = Course.find(params[:course_id])

      if course.opened? 
        yield course
      else
        return false
      end
    end

    def create_subscription(course)
      Subscription.create(email: params[:email], course: course)
    end
  end
end