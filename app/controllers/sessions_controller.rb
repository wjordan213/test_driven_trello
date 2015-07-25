class SessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.find_by_credentials(*user_params)
    if @user
      login! @user
      redirect_to '/static_pages/start'
    end
  end
end
