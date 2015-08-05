class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :logged_in?, :current_user

  def login!(user)
    user.update!(session_token: User.generate_session_token)
    session[:session_token] = user.session_token
  end

  def logout!
    @current_user = nil
    session[:session_token] = nil
  end

  def logged_in?
    !!current_user
  end
  
  def current_user
    @current_user ||= User.find_by(session_token: session[:session_token])
    @current_user
  end
  
  private

  def user_params
    params.require(:user).permit(:username, :password)
  end
end
