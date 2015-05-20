class Movie < ActiveRecord::Base

	validates :title, presence: true

	has_many :movie_characters

	accepts_nested_attributes_for :movie_characters
end
