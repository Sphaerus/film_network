module TopicHelper 
  
  def display_resource_name(resource)
    case resource
    when Person
        return resource.name
    when Movie
        return resource.title
    end
  end
end
