require "rails_helper"

feature "admin views events" do
  scenario "and filter by action" do
    visit root_path
    expect(page).to have_content "Hello World"
  end
end