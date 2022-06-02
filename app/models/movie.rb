class Movie < ApplicationRecord
  has_many :ordered_choices
  serialize :keyword, Array
  serialize :actor, Array
  serialize :genre, Array
end
