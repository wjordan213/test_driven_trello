class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def login!(user)
    user.update!(session_token: User.generate_session_token)
    session[:session_token] = user.session_token
  end
end
