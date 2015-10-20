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

    describe "next_issue" do
      it "renders" do
        email = create(:email, subject: 'Welcome', body: 'Hi *there*')
        subscription = create(:subscription)

        mail = SubscriptionMailer.next_issue(id: subscription.id, email_id: email.id)

        expect(mail.subject).to eq(email.subject)
        expect(mail.to).to eq([subscription.email])
        expect(mail.from).to eq([HiThere.from])
        expect(mail.body.encoded).to include('<p>Hi <em>there</em></p>')
        expect(mail.body.encoded).to include(unsubscribe_subscription_path(token: subscription.token))
      end
    end

    describe "preview_email" do
      it "renders" do
        email = create(:email, subject: 'Welcome', body: 'Hi *there*')
        
        mail = SubscriptionMailer.preview_email(id: email.id, to: 'admin@example.com')

        expect(mail.subject).to eq(email.subject)
        expect(mail.to).to eq(['admin@example.com'])
        expect(mail.from).to eq([HiThere.from])
        expect(mail.body.encoded).to include('<p>Hi <em>there</em></p>')
      end
    end
  end
end


