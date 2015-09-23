require "rails_helper"

feature "unauthorized are redirected" do
  scenario "to configured path" do
    HiThere.redirect_unauthorized_path = '/'

    visit hi_there.courses_path

    expect(current_path).to eq "/"
  end
end
