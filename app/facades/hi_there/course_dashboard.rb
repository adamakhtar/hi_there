module HiThere
  class CourseDashboard
    def initialize(course)
      @course = course
    end

    def title
      course.title
    end

    def total_unsubscribes_count
      subscriptions.with_unsubscribed_state.count
    end

    def total_subscriptions_count
      subscriptions.count
    end

    def total_completed_count
      subscriptions.with_completed_state.count
    end


    def list_growth
      subscriptions.where('activated_at IS NOT NULL').group_by_day(:activated_at).count
    end

    def unsubscribes_per_email
      course.emails.select('subject, count(s.id) as unsubscribe_count').
                    joins("LEFT OUTER JOIN hi_there_subscriptions s ON hi_there_emails.id = s.previous_email_id AND s.workflow_state = 'unsubscribed'").
                    group(:id).map do |email|
                      [email.subject, email.unsubscribe_count]
                    end
    end

    private

    attr_reader :course

    def subscriptions
      @subscriptions ||= course.subscriptions
    end
  end
end