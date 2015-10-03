module HiThere
  class FulfillSubscriptions
    def initialize(subscription_scope=Subscription.all)
      @subscription_scope = subscription_scope
    end

    def perform
      activated_and_overdue_subscriptions.find_each do |subscription|
        operation = FullFillSubscription.new(subscription)
        operation.perform
      end
    end

    private

    def activated_and_overdue_subscriptions
      @subscription_scope.with_activated_state.overdue
    end
  end
end