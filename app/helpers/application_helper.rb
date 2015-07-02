module ApplicationHelper
  
  def display_search_results_title(record)
    case record
    when Movie
      record.title
    when Person
      return record.name
    else
      return "unknown"
    end
  end
  
  def display_image(record)
    case record
    when Movie
      record.poster if record.poster
    when Person
      record.portrait if record.portrait
    end
  end
  
  def search_result_path(record)
    case record
    when Movie
      movie_path(record)
    when Person
      person_path(record)
    end
  end
end
