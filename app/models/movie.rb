class Movie < ApplicationRecord
  has_many :ordered_choices, dependent: :destroy
  has_many :wishes, dependent: :destroy
  has_many :movie_seens, dependent: :destroy

  serialize :keyword, Array
  serialize :actor, Array
  serialize :genre, Array
end
