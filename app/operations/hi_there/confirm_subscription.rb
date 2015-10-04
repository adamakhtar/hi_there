module HiThere
  class ConfirmSubscription
    def initialize(subscription)
      @subscription = subscription
    end

    def perform
      if course_opened? and start_subscription_shedule        
        true
      else
        false
      end      
    end

    private

    def course_opened?
      subscription.course.opened?
    end

    def start_subscription_shedule
      schedule = SubscriptionSchedule.new(subscription)
      schedule.start
    end

    attr_reader :subscription 
  end
end