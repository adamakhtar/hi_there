require "rails_helper"

feature "subscriber unsubscribes from course" do
  scenario "with valid token" do
    subscription = create(:subscription, :activated)

    visit hi_there.unsubscribe_subscription_path(token: subscription.token)

    expect(page).to have_content t('hi_there.subscriptions.unsubscribed.title')
    expect(page).to have_content t('hi_there.subscriptions.unsubscribed.confirmation')
  end

  scenario "with invalid token" do
    visit hi_there.unsubscribe_subscription_path(token: 'junk')

    expect(page).to have_content t('hi_there.subscriptions.sorry')
    expect(page).to have_content t('hi_there.subscriptions.invalid')
  end
end