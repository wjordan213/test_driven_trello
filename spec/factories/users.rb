FactoryGirl.define do
  factory :user do
    username "harrisjordan"
    password_digest BCrypt::Password.create('password')
  end

end
