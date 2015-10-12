require "rails_helper"

feature "admin can view course emails" do
  scenario "invididually" do
    course = create(:course)
    email = create(:email, interval: 1, course: course, subject: 'Hi there', body: 'Heads *up*')
    
    signed_in_admin
    visit hi_there.course_email_path(course, email)
    
    expect(page).to have_content('Hi there')
    expect(page).to have_content('<p>Heads <em>up</em></p>')
  end

  scenario "as a list" do
    course = create(:course)
    email_a = create(:email, interval: 1, course: course)
    email_b = create(:email, interval: 3, course: course)

    signed_in_admin
    visit hi_there.course_path(course)

    click_link 'Emails'
    
    within('.course-emails-list > tr:nth-child(1)') do
      expect(page).to have_content email_a.subject
    end
    within('.course-emails-list > tr:nth-child(2)') do
      expect(page).to have_content email_b.subject
    end
  end
end