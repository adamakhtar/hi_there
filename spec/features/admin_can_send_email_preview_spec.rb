require "rails_helper"

feature "admin can send preview email" do
  scenario "via email page" do
    course = create(:course)
    email = create(:email, interval: 1, course: course, subject: 'Hi there', body: 'Heads *up*')
    
    signed_in_admin
    visit hi_there.course_email_path(course, email)

    click_link t('hi_there.previews.actions.send_email')
    
    expect(page).to have_content t('hi_there.previews.delivered')
  end
end