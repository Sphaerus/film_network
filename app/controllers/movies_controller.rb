class MoviesController < ApplicationController
	before_action :set_movie, only: [:show, :edit, :update, :destroy]

	def show
	end

	def new
		@movie = Movie.new
    @movie.movie_people.build
	end
  
  def edit
    @movie.movie_people.build if @movie.movie_people.empty?
  end

	def create
		@movie = Movie.new(movie_params)
    
		respond_to do |format|
			if @movie.save
				format.html { redirect_to movie_path(@movie), notice: "Movie succesfully created"}
			else        
        
				format.html { render action: "new" }
			end
		end
	end
  
  def update
    @movie.assign_attributes(movie_params)
    delete_movie_people
    respond_to do |format|
      if @movie.save
        #delete_movie_people
        format.html {redirect_to @movie, notice: "Movie update successfuly completed!"}
      else
        format.html {render action: "edit", notice: @movie.errors}
      end
    end
  end

	def destroy
		@movie.destroy
    
		respond_to do |format|
			format.html { redirect_to root_path, notice: "Movie deleted"}
		end
	end

	private

	def movie_params
		params.require(:movie).permit(:title, :production, :release_date, :description, movie_people_attributes: [:id, :movie_id, :person_id, :job, :role_name])
	end
  
  def delete_movie_people
    if !@movie.movie_people.empty?
      ids = params["movie"]["movie_people_attributes"].values.map {|hash| hash["id"].to_i }
      @movie.movie_people.select {|movie_person| !movie_person.new_record? && !ids.include?(movie_person.id)}.map(&:destroy)
    end
  end

	def set_movie
		@movie = Movie.find(params[:id])
	end	
end
