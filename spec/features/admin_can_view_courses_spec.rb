require "rails_helper"

feature "admin can view courses" do
  scenario "as a list" do
    signed_in_admin
    visit hi_there.courses_path
    
    expect(page).to have_content t('hi_there.courses.index.title')
    expect(page).to have_content "How to lose weight in 7 days"
    expect(page).to have_content "The secrets to wealth"
  end
end