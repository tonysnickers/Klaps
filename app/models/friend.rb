class Friend < ApplicationRecord
  belongs_to :user
  belongs_to :users_friend, class_name: "User", foreign_key: :users_friend_id
end
