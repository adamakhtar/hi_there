require_dependency "hi_there/application_controller"

module HiThere
  class PreviewsController < ApplicationController
    def deliver
      @email = find_email
      SubscriptionMailer.preview_email(id: @email.id, to: HiThere.reply_to).deliver_later
      flash[:success] = t('hi_there.previews.delivered')
      redirect_to course_email_path(@email.course, @email)
    end

    private

    def find_email
      Email.find(params[:email_id])
    end
  end
end
