require "rails_helper"

feature "admin can view subscriptions" do
  scenario "via a course page" do
    course = create(:course)
    subscription = create(:subscription, course: course, next_issue_number: 1)
    
    signed_in_admin
    visit hi_there.course_path(course)

    click_link t('hi_there.courses.actions.subscriptions')

    expect(page).to have_content subscription.email
    expect(page).to have_content subscription.previous_issue_number
    expect(page).to have_content subscription.current_state
    expect(page).to have_content l(subscription.created_at, format: :short)
  end
end