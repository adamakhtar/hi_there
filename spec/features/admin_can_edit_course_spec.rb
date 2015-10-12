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
    click_button t('hi_there.common.actions.update') 
    
    expect(page).to have_content t('hi_there.courses.updated')
    expect(page).to have_content "Secrets to being popular"
  end
end