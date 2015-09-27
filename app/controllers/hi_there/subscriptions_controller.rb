require_dependency "hi_there/application_controller"

module HiThere
  class SubscriptionsController < ApplicationController

    def create
      course = CreateSubscription.new(subscription_params).perform

      if course.valid?
        redirect_to thank_you_path
      else
        render :new
      end
    end
  end
end
