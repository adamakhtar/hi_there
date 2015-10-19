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
      subscription.next_email = next_email
      subscription.next_email_at = synchronize_delivery_with_specified_delivery_time
      subscription.save!
    end

    def next_email
      @next_email ||= course.emails.first
    end

    def synchronize_delivery_with_specified_delivery_time       
      scheduled_time = DateTimeDecorator.new(next_email.due_from_now)
      synchronized_time = scheduled_time.wind_forward_to(course.deliver_at.strftime("%H:%M"))
    end

    attr_reader :subscription 
  end
end
