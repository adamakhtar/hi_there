module HiThere
  class AdvanceSubscription
    def initialize(subscription)
      @subscription = subscription
      @course = subscription.course
    end

    def perform        
      return false if subscription_already_completed?

      previous_email = subscription.next_email
      last_delivered_at = subscription.next_email_at

      if next_email = previous_email.next_in_line
        next_email_at = next_email.due_from(last_delivered_at)
      end

      true if subscription.update_attributes(      
        previous_email: previous_email,
        next_email: next_email,
        next_email_at: next_email_at
      )
    end

    private

    def subscription_already_completed?
      subscription.next_email.nil?
    end

    attr_reader :subscription, :course
  end
end