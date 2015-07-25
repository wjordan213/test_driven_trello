module Features
  def sign_up_as(options)
    visit new_user_url

    options[:username] && fill_in("user_username", with: options[:username])
    options[:password] && fill_in("user_password", with: options[:password])
    
    click_on "Submit"
  end

  def sign_in_as(options)
    visit new_session_url

    options[:username] && fill_in("user_username", with: options[:username])
    options[:password] && fill_in("user_password", with: options[:password])
    
    click_on "Submit"
  end
end
