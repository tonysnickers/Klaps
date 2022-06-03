class QuizzChoice < ApplicationRecord
  belongs_to :group
  belongs_to :user
  serialize :genre, Array
end
