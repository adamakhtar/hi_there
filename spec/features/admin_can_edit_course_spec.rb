require "rails_helper"

feature "admin can edit course" do
  scenario "title" do
    course = create(:course)
    signed_in_admin
    visit hi_there.courses_path

    click_link course.title
    click_link t('hi_there.common.actions.edit')
    fill_in 'Title', with: 'Secrets to being popular'
    fill_in 'Description', with: 'All you need to know about charisma'
    select '12', from: 'course_deliver_at_4i'
    select '59', from: 'course_deliver_at_5i'
    click_button t('hi_there.common.actions.update') 
    
    expect(page).to have_content t('hi_there.courses.updated')
    expect(page).to have_content "Secrets to being popular"
    expect(page).to have_content "All you need to know about charisma"
    expect(page).to have_content "12:59"
  end
end