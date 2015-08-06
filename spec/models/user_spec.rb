require 'rails_helper'
require 'byebug'

RSpec.describe User, type: :model do
  
  it "validates the presence of a name" do
    no_username = User.new(password: "password") 
    expect(no_username).not_to be_valid
  end

  it "validates the presence of a password digest" do
    no_pd = User.new(username: "wazzaa", password_digest: nil) 
    expect(no_pd).not_to be_valid
  end

  it "validates the length of a password digest to be greater than or equal to six" do
    wrong_length = User.new(username: "helloworld", password: "passw") 
    expect(wrong_length).not_to be_valid
  end

  it "validates the uniqueness of a name" do
    FactoryGirl.create(:user)
    copied_user = FactoryGirl.build(:user) 
    expect(copied_user).not_to be_valid
  end

  describe "#password=" do
    it "creates a password digest with password" do
      temp_user = User.new(username: "harris jordan") 
      temp_user.password = "hamsters"
      expect(temp_user.password_digest).not_to be_nil
    end
  end

  describe "#is_password?" do
    user = FactoryGirl.create(:user) 
    it "returns true if the given password belongs to the user" do
      expect(user.is_password?('password')).to be true
    end
  end
end
