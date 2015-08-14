require "rails_helper"
describe Api::BoardsController do

  let (:board) { double(Board, title: "hello", user_id: 1)}

  describe "user is logged in" do
    render_views
    let(:user) { instance_double(User, id: 1) }

    before(:each) do
      allow(controller).to receive(:current_user).and_return(user)
    end

    describe "#index" do

      let(:board2) { double(Board, title: "world") }
      let(:boards) { [board, board2] }

      it "renders the user's boards" do
        allow(user).to receive(:boards).and_return(boards)
        get :index
        expect(response.body).to match 'hello'
      end

    end

    describe "#create" do
      
      describe "with valid params" do

        it "creates a board" do
          expect do
            post :create, { board: { title: "hello", user_id: 1 } }
          end.to change(Board, :count).by(1)
        end
      end
      
      describe "with invalid params" do
        it "does not create a board" do
          expect do
            post :create, { board: { title: nil, user_id: nil } }
          end.to_not change(Board, :count)
        end

        it "renders status code of 400 invalid" do
          post :create, { board: { title: nil, user_id: nil } }
          expect(response.status).to eq(400)
        end
      end
    end

    describe "#show" do

      before(:each) do
        mock_board_model(board)
      end

      it "renders json for boards belonging to the current user" do
        mock_board_ownership(board)
        get :show, { id: 1 }
        expect(response).to render_template(:show)
      end

      it "does not allow a user to access another user's boards" do
        mock_board_ownership(board, false)
        get :show, { id: 1 }
        expect(response.status).to eq(401)
        expect(response).to_not render_template(:show)
      end

    end

    describe "#destroy" do

      before(:each) do
        create_and_mock_board
      end

      it "destroys a user's boards" do
        allow(@board).to receive(:is_owner?).and_return(true)
        expect do
          delete :destroy, { id: @board.id }
        end.to change(Board, :count).by(-1)
      end

      it "does not allow a user to destroy a board belonging to another user" do
        allow(@board).to receive(:is_owner?).and_return(false)
        expect do
          delete :destroy, { id: @board.id }
        end.to_not change(Board, :count)
        expect(response.status).to eq(401)
      end
    end

    describe "#update" do

      before(:each) do
        create_and_mock_board
      end

      it "updates a user's boards" do
        confirm_start_title
        update_board
        confirm_new_title
      end

      it "does not allow a user to update a board belonging to another user" do
        mock_board_ownership(@board, false)
        confirm_start_title
        update_board
        confirm_new_title("hello")
      end

    end
  end

  describe "user is logged out" do

    before(:each) do
      allow(controller).to receive(:logged_in?).and_return(false)
    end

    describe "boards index" do
      it "redirects the user to the login page" do
        get :index
        expect(response).to redirect_to new_session_url
      end
    end

    describe "#create" do
      it "redirects the user to the login page" do
        post :create, { board: { title: "Hello", user_id: 1 } }
        expect(response).to redirect_to new_session_url
      end
    end

  end
end
