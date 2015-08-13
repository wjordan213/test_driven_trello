module BoardsControllerSpecHelper

  def stub_board_model(board)
      allow(Board).to receive(:find).and_return(board)
  end

end
