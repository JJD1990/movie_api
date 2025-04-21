class Actor < ApplicationRecord
  has_and_belongs_to_many :movies, through: :actors_movies
end
