module Api
  class BoardsController < ApplicationController

    def index
      @boards = current_user.boards
      render 'api/boards/index.json.jbuilder'
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
