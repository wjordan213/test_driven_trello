module Features
  def create_valid_board
    create_board("My New Board")
  end

  def create_board(title)
    click_on "Create new board..."
    fill_out "Title", with: "My New Board"
    click_on "Submit"
  end
end
