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
end
