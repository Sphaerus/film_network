class CharactersController < ApplicationController

	def show
		@character = Character.find(params[:id])
	end

	def new
		@character = Character.new
	end

	def edit
		@character = Character.find(params[:id])
		@movie_characters = @character.movie_characters.build
	end

	def create
		@character = Character.new(character_params)

		respond_to do |format|
			if @character.save
				format.html { redirect_to @character, notice: "character successfully created"}
			else
				format.html { render "new" }
			end
		end
	end

	def update
		@character = Character.find(params[:id])


		respond_to do |format|
			
			if @character.update_attributes(character_params)
				format.html { redirect_to @character, notice: "character successfully updated"}
			else
				format.html { render "edit" }
			end
		end
	end

	def autocomplete
		a=1
		debugger
		a=1
	end

	private

	def character_params
		params.require(:character).permit(:name, :description, movie_characters_attributes: [:movie_id, :character_id, :id])
	end

end