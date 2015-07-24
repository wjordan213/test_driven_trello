require 'rails_helper'

RSpec.describe User, type: :model do
  # make a test for password=
  describe "#password=" do
    it "creates a password digest with password" do
      user = User.new(username: "harris jordan")
      user.password = "hamsters"

      expect(user.password_digest).not_to be_nil
    end
  end
end
