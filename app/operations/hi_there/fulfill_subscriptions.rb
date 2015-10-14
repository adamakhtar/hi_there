module HiThere
  class FulfillSubscriptions
    def initialize(subscription_scope=Subscription.all)
      @subscription_scope = subscription_scope
    end

    def perform
      @subscription_scope.find_each do |subscription|
        operation = FulfillSubscription.new(subscription)
        operation.perform
      end
    end
  end
end