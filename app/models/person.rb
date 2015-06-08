class Person < ActiveRecord::Base
  mount_uploader :portrait, PortraitUploader
  
  has_many :movie_people
  
  def self.autocomplete(query)
    result = Person.where("name regexp '#{query}'")
    {"suggestions" => result.map {|person| {"data" => person.id.to_s, "value" => person.name}}
    }.to_json
  end
end
