
module HiThere
  class SubscriptionSchedule

    def initialize(subscription)
      @subscription = subscription
      @course = subscription.course
    end
        
    def advance
      if next_issue.present?
        move_to_next_issue
      else
        mark_as_complete
      end
    end

    def current_issue
      @due_issue ||= course.issue(current_issue_number)
    end

    def start
      if first_email = course.emails.first
        subscription.update_next_issue!(issue_number: 1, delivery_at: Time.current + first_email.interval.days)
        subscription.activate!
        true
      else
        false
      end
    end

    private

    attr_reader :course, :subscription

    def next_issue
      @next_issue ||= course.issue(next_issue_number)
    end

    def current_issue_number
      subscription.next_issue_number
    end

    def next_issue_number
      subscription.next_issue_number + 1
    end

    def move_to_next_issue
      subscription.update_next_issue!(issue_number: next_issue.issue_number, delivery_at: subscription.next_delivery_at + next_issue.interval.days)
    end

    def mark_as_complete
      subscription.complete!
      subscription.update_attributes(next_delivery_at: nil, next_issue_number: nil) 
    end
  end
end