module HiThere
  class SubscriptionMailerPreview < ActionMailer::Preview
    # Preview this email at http://localhost:3000/rails/mailers/
    def confirm_your_email
      SubscriptionMailer.confirm_your_email(id: Subscription.first.id)
    end
  end
end
