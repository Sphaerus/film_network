class PeopleController < ApplicationController

	def show
		@person = Person.find(params[:id])
	end

	def new
		@person = Person.new
	end

	def edit
		@person = Person.find(params[:id])
	end

	def create
		@person = Person.new(persons_params)

		respond_to do |format|
			if @person.save
				format.html { redirect_to @person, notice: "Person successfully added"}
			else
				format.html { redner "new" }
			end
		end
	end

	def update
		@person = Person.find(params[:id])

		respond_to do |format|
			if @person.update_attributes(persons_params)
				format.html { redirect_to @person, notice: "Person successfully edited"}
			else
				format.html { redner "edit" }
			end
		end
	end

	private

	def persons_params
		params.require(:person).permit(:name, :born, :died, :description)
	end
end