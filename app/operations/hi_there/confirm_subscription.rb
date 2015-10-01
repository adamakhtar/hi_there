module HiThere
  class ConfirmSubscription
    def initialize(subscription)
      @subscription = subscription
    end

    def perform
      mark_as_confirmed
      if start_subscription_shedule        
        true
      else
        false
      end      
    end

    private

    def mark_as_confirmed
      subscription.confirm!
    end

    def start_subscription_shedule
      schedule = SubscriptionSchedule.new(subscription)
      schedule.start
    end

    attr_reader :subscription 
  end
end