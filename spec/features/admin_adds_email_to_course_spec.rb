require "rails_helper"

feature "admin adds email to a course" do
  scenario "when course is draft" do
    course = create(:course)
    signed_in_admin
    visit hi_there.course_path(course)

    click_link t('hi_there.courses.actions.add_email')
    fill_in 'Subject', with: 'Part 1 Email'
    fill_in 'Body', with: 'blah blah blah'
    fill_in 'Released after', with: '23'
    click_button t('hi_there.common.actions.save') 

    expect(page).to have_content t('hi_there.emails.created')
    expect(page).to have_content "Part 1 Email"
    expect(page).to have_content "23"
  end
end