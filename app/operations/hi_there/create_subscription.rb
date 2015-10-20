module HiThere
  class CreateSubscription
    def initialize(params={})
      @params = params
    end

    def perform
      Subscription.transaction do
        course = find_opened_course
        subscriber = create_subscriber!
        subscription = create_subscription!(subscriber, course)
        deliver_confirm_email_request(subscription)          
        subscription        
      end

    rescue ActiveRecord::RecordInvalid
      return false
    end

    private

    attr_reader :params

    def deliver_confirm_email_request(subscription)
      SubscriptionMailer.confirm_your_email(id: subscription.id).deliver_later
    end

    def find_opened_course
      Course.with_opened_state.find(params[:course_id])
    end

    def create_subscriber!
      Subscriber.where(email: params[:email]).first_or_create!
    end

    def create_subscription!(subscriber, course)
      subscriber.subscriptions.create!(course: course)
    end
  end
end

