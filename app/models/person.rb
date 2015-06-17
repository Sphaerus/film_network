class Person < ActiveRecord::Base
  mount_uploader :portrait, PortraitUploader
  
  has_many :movie_people
  has_many :topics, as: :subject
  has_many :scores, as: :resource
  
  def self.autocomplete(query)
    result = Person.where("name regexp '#{query}'")
    {"suggestions" => result.map {|person| {"data" => person.id.to_s, "value" => person.name}}
    }.to_json
  end
end
