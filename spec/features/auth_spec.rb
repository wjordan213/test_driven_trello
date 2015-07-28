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
  it "does not display the logout button when logged out" do
    visit root_url

    expect(page).not_to have_content("logout")
  end

  it "displays the sign in and sign up buttons when logged out" do
    visit root_url

    expect(page).to have_content("Sign in")

    expect(page).to have_content("Signup")
  end

  it "has a login page" do
    visit root_url

    click_on "Sign in"

    expect(page).to have_content("Login")
  end
    
  context "successfully" do
    before(:each) do
      user = FactoryGirl.create(:user)

      sign_in_as(username: 'harrisjordan', password: 'password')
    end

    it "shows the username on the homepage after login" do
      expect(page).to have_content 'harrisjordan'
    end

    it "displays the logout button" do
      expect(page).to have_content('logout')
    end

    it "does not display links to sign in and sign up" do
      expect(page).not_to have_content('Sign in')
      expect(page).not_to have_content('Signup')
    end
  end
  
  context "unsuccessfully" do
    before(:each) do
      FactoryGirl.create(:user)
    end

    it "displays an error message if given a username that is not in the database" do
      sign_in_as username: 'harrisharris', password: 'password'

      expect(page).to have_content("Invalid input. Try again")
    end

    it "displays an error message if given the wrong password" do 
      sign_in_as username: 'harrisjordan', password: 'passwordasdf'

      expect(page).to have_content("Invalid input. Try again")
    end
  end
end

feature "Logging out" do
  context "successfully" do
    before(:each) do
      FactoryGirl.create(:user)
    end

    it "logs the user out of the session" do
      sign_in_as username: 'harrisjordan', password: 'password'
      
      user = User.find_by(username: 'harrisjordan')

      click_on 'logout'

      user.reload

      expect(user.session_token).to be_nil 
    end

    it "redirects the user to the home page" do
      sign_in_as username: 'harrisjordan', password: 'password'

      click_on "logout"

      expect(page).to have_content("Home Page")
    end
  end
end
