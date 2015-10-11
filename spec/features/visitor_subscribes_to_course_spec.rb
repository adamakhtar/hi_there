require "rails_helper"

feature "visitor subscribes to course" do
  scenario " via engine's form with valid email" do
    course = create(:course, :opened, emails: [create(:email)])
    visit hi_there.new_subscription_path(course_id: course.id)

    fill_in "subscription_email", with: 'adam@example.com'
    click_button t('hi_there.subscriptions.forms.subscribe')

    expect(page).to have_content t('hi_there.subscriptions.confirmation_required')

    subscription = HiThere::Subscription.last

    visit hi_there.confirm_subscription_path(token: subscription.token)

    expect(page).to have_content t('hi_there.subscriptions.confirmed')
  end

  scenario "via engine's form with invalid email" do
    course = create(:course, :opened, emails: [create(:email)])
    visit hi_there.new_subscription_path(course_id: course.id)

    fill_in "subscription_email", with: 'garbage'
    click_button t('hi_there.subscriptions.forms.subscribe')

    expect(page).to have_content('is invalid')
  end

  scenario "via own form with valid email" do
    course = create(:course, :opened, name: 'test_course', emails: [create(:email)])
    visit main_app.landing_page_path

    fill_in "subscription_email", with: 'adam@example.com'
    click_button 'Sign up'

    expect(page).to have_content t('hi_there.subscriptions.confirmation_required')
  end

  scenario "via own form with invalid email" do
    course = create(:course, :opened, name: 'test_course', emails: [create(:email)])
    visit main_app.landing_page_path

    fill_in "subscription_email", with: 'garbage'
    click_button 'Sign up'

    expect(page).to have_content('is invalid')
  end
end