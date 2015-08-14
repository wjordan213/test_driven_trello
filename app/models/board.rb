class Board < ActiveRecord::Base
  validates :user_id, :title, presence: true

  belongs_to(:user,
          class_name: "User",
          foreign_key: :user_id,
          primary_key: :id
          ) 
  
  def is_owner?(user)
    user && user.id == self.user_id
  end
end
