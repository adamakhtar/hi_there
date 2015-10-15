module HiThere
  class FulfillSubscriptions
    def initialize(subscription_scope=Subscription.all)
      @subscription_scope = subscription_scope
    end

    def perform
      active_and_overdue_subscriptons.find_each do |subscription|
        Subscription.transaction do
          result = FulfillSubscription.new(subscription).perform && 
                   AdvanceSubscription.new(subscription).perform       
  
          raise ActiveRecord::Rollback unless result == true                             
        end
      end
    end

    def active_and_overdue_subscriptions
      @subscription_scope.with_activated_state.overdue
    end
  end
end