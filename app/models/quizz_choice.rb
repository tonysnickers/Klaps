class QuizzChoice < ApplicationRecord
  belongs_to :group
  belongs_to :user
  serialize :keyword, Array
  serialize :genre, Array
end
