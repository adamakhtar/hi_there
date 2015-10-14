require 'rails_helper'

module HiThere
  RSpec.describe SubscriptionsController, type: :controller do
    before do
      @routes = HiThere::Engine.routes
    end

    describe "#create" do
      context "when bot" do
        it "fakes success" do
          post :create, secret_field: "honeytrap"

          expect(response).to be_created
          expect(Subscription.count).to eq 0
        end
      end
    end

    describe "#destroy" do
      context "when valid subscription" do
        it "is success" do
          subscription = double(:subscription, stamp_unsubscribe!: true)
          allow(controller).to receive(:find_subscription_by_token).and_return(subscription)
          
          get :destroy, token: "123abc"

          expect(subscription).to have_received(:stamp_unsubscribe!)
          expect(response).to redirect_to unsubscribed_subscription_path
        end
      end
    end
  end
end
