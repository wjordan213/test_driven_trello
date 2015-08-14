module Api
  class BoardsController < ApiController

    before_filter :set_default_response_format
    
    def index
      @boards = current_user.boards
    end

    def show
      @board = Board.find(params[:id])
      execute_if_user_owns_board { render :show }
    end

    def create
      @board = Board.new(board_params)
      if @board.save
        render :show
      else
        render json: @board.errors.full_messages, status: :bad_request
      end
    end

    def update
      @board = Board.find(params[:id])
      execute_if_user_owns_board do
        @board.update!(board_params)
        render :show
      end
    end

    def destroy
      @board = Board.find(params[:id])

      execute_if_user_owns_board do
        @board.destroy
        render :show
      end
    end

    private

    def execute_if_user_owns_board(&prc)
      if @board.is_owner?(current_user)
        prc.call
      else
        render json: ["That isn't your board!"], status: :unauthorized
      end
    end

    def set_default_response_format
      request.format = :json
    end

    def board_params
      params.require(:board).permit(:title, :user_id)
    end

  end
end
