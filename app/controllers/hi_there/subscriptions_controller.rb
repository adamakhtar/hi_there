require_dependency "hi_there/application_controller"

module HiThere
  class SubscriptionsController < ApplicationController
    skip_before_filter :ensure_authorized

    def new
      course = Course.find(params[:course_id])
      @subscription = Subscription.new(course: course)
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
      subscription = Subscription.where(token: params[:token]).take!
      subscription.confirm!
      redirect_to confirmed_subscription_path
    end

    def confirmed
    end

    protected

    def subscription_params
      params.require(:subscription).permit(:email, :course_id)
    end
  end
end
