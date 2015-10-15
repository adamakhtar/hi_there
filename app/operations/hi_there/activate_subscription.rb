module HiThere
  class ActivateSubscription
    def initialize(subscription)
      @subscription = subscription
    end

    def perform
      if subscription.course.opened?
        subscription.activate_and_stamp!        
        set_next_email
        true
      else 
        false
      end
    end

    private

    def course
      @course ||= subscription.course
    end

    def set_next_email
      next_email = course.emails.first
      subscription.next_email = next_email
      subscription.next_email_at = next_email.due_from_now
      subscription.save!
    end

    attr_reader :subscription 
  end
end