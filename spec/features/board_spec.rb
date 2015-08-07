require "rails_helper"

feature "Boards" do

  context "after login" do

    before(:each) do
      sign_up_as_valid_user
    end

    scenario "user is brought to boards index" do
      expect(page).to have_content("My Boards")
    end
   
    describe "board creation" do

      before(:each) do
        create_valid_board
      end

      it "creates a new board", :js => true do
        expect(Board.count).to eq(1)
      end

      describe "board show" do

        it "has a board show page", :js => true do
          click_on('My New Board')
          expect(page).to have_content("Todo for My New Board")
        end

      end
    end
  end
end
