class Group < ApplicationRecord
  belongs_to :user
  has_many :ordered_choices
  has_many :groups_users
  has_many :quizz_choices
  has_many :users, through: :groups_users
end
