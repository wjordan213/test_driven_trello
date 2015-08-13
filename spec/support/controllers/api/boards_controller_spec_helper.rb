module BoardsControllerSpecHelper
  def setup_board_double
      let(:board) { instance_double(Board, title: "hello", user_id: 1) }

  end
  
  def stub_board_model
      before(:each) do
        allow(Board).to receive(:find).and_return(board)
      end
  end

end
