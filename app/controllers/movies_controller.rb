class MoviesController < ApplicationController
	before_action :set_movie, only: [:show, :edit, :destroy]

	def show
	end

	def new
		@movie = Movie.new
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

	def destroy
		@movie.destroy
		redirect_to root_path
	end

	private

	def movie_params
		params.require(:movie).permit(:title, :production, :release_date, :description)
	end

	def set_movie
		@movie = Movie.find(params[:id])
	end	
end
