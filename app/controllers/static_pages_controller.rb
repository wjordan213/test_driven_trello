class StaticPagesController < ApplicationController
  def index
  end

  def start
    @user = User.find_by(session_token: session[:session_token])
  end
end
