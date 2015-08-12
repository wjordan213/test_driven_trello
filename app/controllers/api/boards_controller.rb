module Api
  class BoardsController < ApplicationController

    def index
      if logged_in?
        @boards = current_user.boards
        render 'api/boards/index.json.jbuilder'
      else
        redirect_to new_session_url
      end
    end

    def new
    end

    def create
    end

    def destroy
    end

    def edit
    end

  end
end
