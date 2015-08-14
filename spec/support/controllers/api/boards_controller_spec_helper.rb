module BoardsControllerSpecHelper

  def mock_board_model(board)
      allow(Board).to receive(:find).and_return(board)
  end

  def create_and_mock_board
    @board = FactoryGirl.create(Board)
    mock_board_model(@board)
  end
end
