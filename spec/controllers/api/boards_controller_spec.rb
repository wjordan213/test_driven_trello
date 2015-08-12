require "rails_helper"

describe Api::BoardsController do

  describe "user is logged in" do
    render_views
    let(:user) { double(User) }

    before(:each) do
      allow(controller).to receive(:current_user).and_return(user)
    end

    describe "boards index" do

      let(:board1) { double(Board, title: "hello") }
      let(:board2) { double(Board, title: "world") }
      let(:boards) { [board1, board2] }

      it "renders the user's boards" do
        allow(user).to receive(:boards).and_return(boards)
        get :index
        expect(response.body).to match 'hello'
      end

    end

  end

  describe "user is logged out" do

    describe "boards index" do

      before(:each) do
        allow(controller).to receive(:logged_in?).and_return(false)
        allow(controller).to receive(:current_user).and_return(nil)
      end

      it "redirects the user to the login page" do
        get :index
        expect(response).to redirect_to new_session_url
      end
    end

  end
end
