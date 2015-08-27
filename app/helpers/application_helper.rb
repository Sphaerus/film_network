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
      record.poster.file ? record.poster : "question_mark.jpg"
    when Person
      record.portrait.file ? record.portrait : "question_mark.jpg"
    when User
      record.avatar.file ? record.avatar : "question_mark.jpg"
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
