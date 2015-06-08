class MoviePerson < ActiveRecord::Base  
  belongs_to :movie
  belongs_to :person
  
  validates :person_id, presence: true
end
