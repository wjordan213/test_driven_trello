module Features
  def sign_up_as(options)
    visit new_user_url

    options[:username] && fill_in("user_username", with: options[:username])
    options[:password] && fill_in("user_password", with: options[:password])
    
    click_on "Submit"
  end

  def sign_up_as_valid_user
    visit new_user_url

    fill_in("user_username", with: "harrisjordan")
    fill_in("user_password", with: "password")

    click_on "Submit"
  end

  def sign_in_as(options)
    visit new_session_url

    options[:username] && fill_in("user_username", with: options[:username])
    options[:password] && fill_in("user_password", with: options[:password])
    
    click_on "Submit"
  end

  def sign_in_as_valid_user
    visit new_session_url

    fill_in("user_username", with: "harrisjordan")
    fill_in("user_password", with: "password")
    
    click_on "Submit"
  end
end
