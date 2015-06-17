class PeopleController < ApplicationController
  
  def index
    @people = Person.page(params[:page]).per(10)
  end

	def show
		@person = Person.find(params[:id])
    @score = current_user.scores.where(resource_id: @person.id).first || @person.scores.build
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
				format.html { render "new" }
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
  
  def destroy
    @person = Person.find(params[:id])
    @person.destroy
    
		respond_to do |format|
			format.html { redirect_to people_path, notice: "Person successfully deleted"}
		end
  end
  
  def autocomplete
    answer = Person.autocomplete(params["query"])

    respond_to do |format|
      format.json { render json: answer}
    end
  end

	private

	def persons_params
		params.require(:person).permit(:name, :born, :died, :description, :portrait)
	end
end