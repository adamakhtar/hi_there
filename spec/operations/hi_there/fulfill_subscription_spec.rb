require 'rails_helper'

module HiThere
  RSpec.describe FulfillSubscription, type: :operation do
    describe "#perform" do
      it "is a success" do
        email = double(:email, id: 1)
        subscription = double(:subscription, id: 1, overdue?: true, next_email: email)
        mailer = stub_mailer(subscription, email)
        operation = FulfillSubscription.new(subscription)

        operation.perform

        expect(mailer).to have_received(:deliver_later)
      end

      def stub_mailer(subscription, email)
        mailer = double(:mailer, deliver_later: true)
        allow(SubscriptionMailer).to receive(:next_issue).with(id: subscription.id, email_id: email.id).and_return(mailer)
        mailer
      end
    end
  end
end
