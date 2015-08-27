class Person < ActiveRecord::Base
  mount_uploader :portrait, PortraitUploader
  
  has_many :movie_people, dependent: :destroy
  has_many :topics, as: :subject, dependent: :destroy
  has_many :scores, as: :resource, dependent: :destroy
  
  def self.autocomplete(query)
    result = Person.where("name regexp '#{query}'")
    {"suggestions" => result.map {|person| {"data" => person.id.to_s, "value" => person.name}}
    }.to_json
  end
  
  def self.search(query)
    if !query.blank?
      Person.where("name regexp '#{query}'")
    else
      Person.all
    end
  end
  
  def movies_as_actor
    self.movie_people.where(job: 0)
  end
  
  def movies_as_director
    self.movie_people.where(job: 1)
  end
  
  def movies_as_screenwriter
    self.movie_people.where(job: 2)
  end
  
  def movies_as_producer
    self.movie_people.where(job: 3)
  end
end
