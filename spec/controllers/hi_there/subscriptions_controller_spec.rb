require 'rails_helper'

module HiThere
  RSpec.describe SubscriptionsController, type: :controller do
    before do
      @routes = HiThere::Engine.routes
    end

    describe "#destroy" do
      context "when valid subscription" do
        it "is success" do
          subscription = double(:subscription, unsubscribe!: true)
          allow(controller).to receive(:find_subscription_by_token).and_return(subscription)
          
          get :destroy, token: "123abc"

          expect(subscription).to have_received(:unsubscribe!)
          expect(response).to redirect_to unsubscribed_subscription_path
        end
      end
    end
  end
end
