require "rails_helper"

feature "admin can view email" do
  scenario "as html" do
    course = create(:course)
    email = create(:email, interval: 1, course: course, subject: 'Hi there', body: 'Heads *up*')
    
    signed_in_admin
    visit hi_there.course_email_path(course, email)
    
    expect(page).to have_content('Hi there')
    expect(page).to have_content('<p>Heads <em>up</em></p>')
  end
end