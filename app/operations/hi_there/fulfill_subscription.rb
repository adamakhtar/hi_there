module HiThere
  class FulfillSubscription

    def initialize(subscription)
      @subscription = subscription
    end

    def perform
      return false unless current_issue
      subscription_schedule.advance
      mail_next_issue
      true
    end

    private 

    attr_reader :subscription

    def mail_next_issue
      SubscriptionMailer.next_issue(id: subscription.id, email_id: current_issue.id).deliver_later
    end

    def subscription_schedule
      @subscription_schedule ||= SubscriptionSchedule.new(subscription)
    end

    def current_issue
      @current_issue ||= subscription_schedule.current_issue
    end
  end
end