class MovieCharacter < ActiveRecord::Base
	attr_accessor :movie_title

  belongs_to :character
  belongs_to :movie

  validates :movie_id, presence: true
end
