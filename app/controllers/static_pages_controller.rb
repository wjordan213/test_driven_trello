class StaticPagesController < ApplicationController
  def index
  end

  def start
    @user = current_user
  end
end
