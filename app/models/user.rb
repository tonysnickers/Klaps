class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :groups
  has_many :group_users
  has_many :my_groups, through: :group_users, source: :group
  has_many :quizz_choices
  has_many :favorites, dependent: :destroy
  has_many :wishes, dependent: :destroy

  has_many :friends, dependent: :destroy
  has_many :users, source: :friend, through: :friends
  validates :username, uniqueness: true
end
