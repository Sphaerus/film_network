class Movie < ActiveRecord::Base
  mount_uploader :poster, PosterUploader
  
  attr_accessor :search_bar
  
  JOBS = {
    0 => :actor,
    1 => :director,
    2 => :screenwriter,
    3 => :producer,
  }

	validates :title, presence: true

	has_many :movie_people, dependent: :destroy
  has_many :topics, as: :subject, dependent: :destroy
  has_many :scores, as: :resource, dependent: :destroy
  has_many :reviews, dependent: :destroy
  
  accepts_nested_attributes_for :movie_people, allow_destroy: true
  
  def self.search(query)
    if !query.blank?
      Movie.where("title regexp '#{query}'")
    else
      Movie.all
    end  
  end
  
  def self.jobs_collection
    JOBS.map { |integer, label|  [label, integer]}
  end
  
  def actors
    movie_people.where("job = 0")
  end
  
  def directors
    movie_people.where("job = 1")
  end
  
  def screenwriters
    movie_people.where("job = 2")
  end
  
  def producers
    movie_people.where("job = 3")
  end
  
  def actors?
    !actors.empty?
  end
  
  def directors?
    !directors.empty?
  end
  
  def producers?
    !producers.empty?
  end
  
  def screenwriters?
    !screenwriters.empty?
  end
end
