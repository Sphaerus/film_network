class MoviesController < ApplicationController
  before_action :authenticate_user!, only: [:edit, :update, :new, :create, :destroy]
	before_action :set_movie, only: [:show, :edit, :update, :destroy]
  
  def index
    if !params[:user_id].blank?
      @movies = Movie.where(user_id: params[:user_id]).paginate(page: params[:page], per_page: 10)
      @user = User.find(params[:user_id])
    else
      @movies = Movie.page(params[:page]).paginate(page: params[:page], per_page: 10) 
    end  
  end

	def show
    @score = current_user.scores.where(resource_id: @movie.id).first || @movie.scores.build if current_user
	end

	def new
		@movie = Movie.new
    @movie.movie_people.build
	end
  
  def edit
    @movie.movie_people.build if @movie.movie_people.empty?
    authorize @movie
  end

	def create
		@movie = Movie.new(movie_params)
    @movie.user_id = current_user.id
    authorize @movie
    
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
    authorize @movie
    delete_movie_people
    respond_to do |format|
      if @movie.save
        format.html {redirect_to @movie, notice: "Movie update successfuly completed!"}
      else
        format.html {render action: "edit", notice: @movie.errors}
      end
    end
  end

	def destroy
    authorize @movie
		@movie.destroy
    
		respond_to do |format|
			format.html { redirect_to root_path, notice: "Movie deleted"}
		end
	end

	private

	def movie_params
		params.require(:movie).permit(:title, :poster, :production, :release_date, :description, movie_people_attributes: [:id, :movie_id, :person_id, :job, :role_name])
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
