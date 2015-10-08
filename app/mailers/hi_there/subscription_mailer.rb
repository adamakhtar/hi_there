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

    def next_issue(id:, email_id:)
      @subscription = Subscription.find(id)
      @email = Email.find(email_id)
      @body  = RenderEmail.new(@email).perform

      mail(
        reply_to: HiThere.reply_to,
        from: HiThere.from, 
        to: @subscription.email,
        subject: @email.subject
      )
    end

    def preview_email(id:, to:)      
      @email = Email.find(id)
      @body = RenderEmail.new(@email).perform
      @subscription = Subscription.new(token: 'dummy')

      mail(
        reply_to: HiThere.reply_to,
        from: HiThere.from, 
        to: to,
        subject: @email.subject,
        template_name: 'next_issue'
      )
    end
  end
end
