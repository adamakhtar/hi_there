require "rails_helper"

feature "admin can delete email" do
  scenario "via email page" do
    course = create(:course)
    email = create(:email, interval: 1, course: course)
    
    signed_in_admin
    visit hi_there.course_path(course)
    click_link 'Emails'
    click_link email.subject
    click_link t('hi_there.emails.actions.delete')
    
    expect(page).to have_content t('hi_there.emails.deleted')
    expect(page).to_not have_content email.subject
  end
end