module HiThere
  class CreateSubscription
    def initialize(params={})
      @params = params
    end

    def perform
      course = find_opened_course
      subscription = create_subscription(course)

      if subscription.valid?
        deliver_confirm_email_request(subscription)
      end

      subscription
    end

    private

    attr_reader :params

    def deliver_confirm_email_request(subscription)
      SubscriptionMailer.confirm_your_email(id: subscription.id).deliver_later
    end

    def find_opened_course
      Course.with_opened_state.find(params[:course_id])
    end

    def create_subscription(course)
      Subscription.create(email: params[:email], course: course, next_issue_number: 1)
    end
  end
end