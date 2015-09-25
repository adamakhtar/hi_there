require "rails_helper"

feature "admin can view courses" do
  scenario "as a list" do
    course_a = create(:course)
    course_b = create(:course)
    
    signed_in_admin
    visit hi_there.courses_path

    expect(page).to have_content t('hi_there.courses.index.title')
    expect(page).to have_content course_a.title
    expect(page).to have_content course_b.title
  end

  scenario "individually" do
    course = create(:course)
    email_a = create(:email, interval: 1, course: course)
    email_b = create(:email, interval: 3, course: course)

    signed_in_admin
    visit hi_there.course_path(course)

    expect(page).to have_content course.title
    within('.course-emails-list > tr:nth-child(1)') do
      expect(page).to have_content email_a.subject
    end
    within('.course-emails-list > tr:nth-child(2)') do
      expect(page).to have_content email_b.subject
    end
  end 
end