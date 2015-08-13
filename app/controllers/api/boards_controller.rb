module Api
  class BoardsController < ApiController

    before_filter :set_default_response_format
    
    def index
      @boards = current_user.boards
    end

    def show
      @board = Board.find(params[:id])

      if @board.is_owner?(current_user)
        render :show
      else
        render json: ["That isn't your board!"], status: :unauthorized
      end
    end

    def create
      @board = Board.new(board_params)
      if @board.save
        render :show
      else
        render json: @board.errors.full_messages, status: :bad_request
      end
    end

    def destroy
      @board = Board.find(params[:id])

      if @board.is_owner?(current_user)
        @board.destroy
        render :show
      else
        render json: ["That isn't your board!"], status: :unauthorized
      end
    end

    private

    def set_default_response_format
      request.format = :json
    end

    def board_params
      params.require(:board).permit(:title, :user_id)
    end

  end
end
