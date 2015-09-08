class HomeController < ApplicationController
  def search
    @people_results = Person.search(params[:query][:query])
    @movies_results = Movie.search(params[:query][:query])
    @records = @people_results + @movies_results
    @records = @records.flatten.sort_by {|record| record.created_at }.reverse

    current_page = params[:page] || 1
    per_page = 10
    @records = WillPaginate::Collection.create(current_page, per_page, @records.size) do   |pager|
      start = (current_page.to_i-1)*per_page
      pager.replace(@records[start, per_page])
    end
  end
  
  def index
    @records = Movie.search(nil) + Person.search(nil)
    @records = @records.flatten.sort_by {|record| record.created_at }.reverse
    
    per_page = 10
    current_page = params[:page] || 1
    @records = WillPaginate::Collection.create(current_page, 10, @records.size) do   |pager|
      start = (current_page.to_i-1)*per_page
      pager.replace(@records[start, per_page])
    end
  end
  
  def info
  end

end
