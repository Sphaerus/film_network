class Character < ActiveRecord::Base
	attr_accessor :search_input

	has_many :movie_characters

	accepts_nested_attributes_for :movie_characters
end
