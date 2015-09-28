module HiThere
  class SubscriptionMailer < ApplicationMailer
    def confirm_your_email(id:)      
      @subscription = Subscription.find(id)
      @course = @subscription.course
      
      mail(
        reply_to: HiThere.reply_to,
        from: HiThere.from, 
        to: @subscription.email,
        subject: t('hi_there.subscription_mailer.confirm_your_email.subject')
      )
    end
  end
end
