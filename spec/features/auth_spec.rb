require "rails_helper"

feature "The signup process" do
  it "has a new user page" do
    visit root_url

    click_on "Signup"
    
    expect(page).to have_content("Sign Up")
  end
  
  feature "signing up a user" do
    context "successfully" do
      it "shows the username on the homepage after signup" do
        visit new_user_url
        
        fill_in "user_username", with: "harrisjordan"
        fill_in "user_password", with: "password"

        click_on "Submit"

        expect(page).to have_content ("harrisjordan")
      end
    end
  end
end

