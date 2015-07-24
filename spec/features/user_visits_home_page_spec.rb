require "rails_helper"

feature "User visits home page" do
  scenario "successfully" do
    visit root_url
    expect(page).to have_content("Test Driven Trello")
  end
end
