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
        sign_up_as username: 'harrisjordan', password: 'password'

        expect(page).to have_content("harrisjordan")
      end
    end

    context "unsuccessfully" do
      it "displays an error message if given a blank username" do
        sign_up_as password: 'password'

        expect(page).to have_content("Username can't be blank")
      end

      it "displays an error message if given a username that is already taken" do
        FactoryGirl.create(:user)
        
        sign_up_as username: 'harrisjordan', password: 'password'

        expect(page).to have_content("Username has already been taken")
      end

      it "displays an error message if given a password under six characters" do
        sign_up_as username: 'harrisjordan', password: 'passw'

        expect(page).to have_content("Password is too short (minimum is 6 characters)")
      end
    end
  end
end

feature "Logging in" do
  it "has a login page" do
    visit root_url

    click_on "Sign in"

    expect(page).to have_content("Login")
  end
    
  context "successfully" do
    it "shows the username on the homepage after login" do
      user = FactoryGirl.create(:user)

      sign_in_as username: 'harrisjordan', password: 'password'

      expect(page).to have_content user.username
    end
  end
  
  context "unsuccessfully" do
    it "displays an error message if given a username that is not in the database" do
      sign_in_as username: 'harrisharris', password: 'password'

      expect(page).to have_content("Invalid input. Try again")
    end

    it "displays an error message if given the wrong password" do 
      FactoryGirl.create(:user)

      sign_in_as username: 'harrisjordan', password: 'passwordasdf'

      expect(page).to have_content("Invalid input. Try again")
    end
  end
end
