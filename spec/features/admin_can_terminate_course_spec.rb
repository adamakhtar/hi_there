require "rails_helper"

feature "admin can terminate course" do
  scenario "via course page" do
    course = create(:course)
    signed_in_admin

    visit hi_there.course_path(course)
    click_button t('hi_there.courses.actions.terminate')

    expect(page).to have_content t('hi_there.courses.terminated')
    expect(page).to have_content t('hi_there.courses.current_state.terminated')
  end
end