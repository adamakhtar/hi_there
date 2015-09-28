require "rails_helper"

module HiThere
  RSpec.describe SubscriptionMailer, type: :mailer do

    include HiThere::Engine.routes.url_helpers
    
    describe "confirm_your_email" do
      it "renders" do
        subscription = create(:subscription)
        mail = SubscriptionMailer.confirm_your_email(id: subscription.id)

        expect(mail.subject).to eq(t('hi_there.subscription_mailer.confirm_your_email.subject'))
        expect(mail.to).to eq([subscription.email])
        expect(mail.from).to eq([HiThere.from])
        expect(mail.body.encoded).to include(confirm_subscription_url(token: subscription.token, host: HiThere.app_domain))
      end
    end
  end
end


