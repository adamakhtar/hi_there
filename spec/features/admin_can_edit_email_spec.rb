require "rails_helper"

feature "admin can edit email" do
  scenario "title" do
    course = create(:course)
    email = create(:email, interval: 1, course: course)
    
    signed_in_admin
    visit hi_there.course_path(course)
    click_link email.subject
    click_link t('hi_there.common.actions.edit')
    fill_in 'Subject', with: 'The last chapter'
    fill_in 'Released after', with: '13'
    fill_in 'Body', with: 'compelling text'
    click_button t('hi_there.common.actions.update')

    expect(page).to have_content t('hi_there.emails.updated')
    expect(page).to have_content "The last chapter"
    expect(page).to have_content "13"
    expect(page).to have_content "compelling text"
  end
end