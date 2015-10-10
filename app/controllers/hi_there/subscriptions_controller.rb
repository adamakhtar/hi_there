require_dependency "hi_there/application_controller"

module HiThere
  class SubscriptionsController < ApplicationController
    skip_before_filter :ensure_authorized
    before_filter :deny_bots, only: :create

    def new
      @course = Course.find(params[:course_id])
      @subscription = Subscription.new(course: @course)
    end 

    def create
      @subscription = CreateSubscription.new(subscription_params).perform
      if @subscription.valid?
        redirect_to confirmation_required_path
      else
        render :new
      end
    end

    def confirmation_required
    end

    def confirm
      operation = ConfirmSubscription.new(find_subscription_by_token)

      if operation.perform
        redirect_to confirmed_subscription_path
      else
        redirect_to invalid_subscription_path
      end
    end

    def confirmed
    end

    def destroy
      if subscription = find_subscription_by_token and subscription.unsubscribe!
        redirect_to unsubscribed_subscription_path
      else
        redirect_to invalid_subscription_path
      end
    end

    protected

    def deny_bots
      # Lie to the bot that the subscription was created.
      head(:created) if params[:secret_field].present?
    end

    def find_subscription_by_token
      Subscription.where(token: params[:token]).take!
    end

    def subscription_params
      params.require(:subscription).permit(:email, :course_id)
    end
  end
end
