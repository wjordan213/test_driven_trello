module BoardsControllerSpecHelper

  def mock_board_model(board)
      allow(Board).to receive(:find).and_return(board)
  end

  def create_and_mock_board
    @board = FactoryGirl.create(Board)
    mock_board_model(@board)
  end

  def update_board_title
    patch :update, { id: @board.id, board: {title: "a new title"} }
    @board.reload
  end

  def confirm_start_title
    expect(@board.title).to eq("hello")
  end

  def confirm_new_title(new_title = "a new title")
    expect(@board.title).to eq(new_title)
  end

  def mock_board_ownership(board, ownership = true)
    allow(board).to receive(:is_owner?).and_return(ownership)
  end

  def request_to_create_board(options)
    post :create, { board: options }
  end
end
