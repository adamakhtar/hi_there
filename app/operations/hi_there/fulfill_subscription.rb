module HiThere
  class FulfillSubscription

    def initialize(subscription)
      @subscription = subscription
    end

    def perform
      return false unless subscription.overdue?
      mail_next_email
      true
    end

    private 

    attr_reader :subscription

    def mail_next_email
      SubscriptionMailer.next_issue(id: subscription.id, email_id: subscription.next_email.id).deliver_later
    end
  end
end