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
end