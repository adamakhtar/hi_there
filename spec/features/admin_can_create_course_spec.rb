require "rails_helper"

feature "admin can create course" do
  scenario "via the courses page" do
    signed_in_admin
    visit hi_there.courses_path

    click_link t('hi_there.courses.actions.new')
    fill_in 'Name', with: 'rich_101'
    fill_in 'Title', with: 'How to be rich'
    fill_in 'Description', with: 'An amazing course'
    select '09', from: 'course_deliver_at_4i'
    select '15', from: 'course_deliver_at_5i'
    click_button t('hi_there.common.actions.save') 

    expect(page).to have_content t('hi_there.courses.created')
    expect(page).to have_content "rich_101"
    expect(page).to have_content "How to be rich"
    expect(page).to have_content "An amazing course"
    expect(page).to have_content "09:15"
  end
end