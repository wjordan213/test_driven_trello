class SessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.find_by_credentials(*user_params)
    if @user
      login! @user
      redirect_to '/static_pages/start'
    else
      @user = User.new
      flash.now[:errors] = ["Invalid input. Try again"]
      render :new
    end
  end

  def destroy
    logout!

    redirect_to root_url
  end
end
