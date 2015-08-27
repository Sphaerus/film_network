class PeopleController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit, :create, :update, :destroy]
  
  def index
    if !params[:user_id].blank?
      @people = Person.where(user_id: params[:user_id]).paginate(page: params[:page], per_page: 10)
      @user = User.find(params[:user_id])
    else
      @people = Person.paginate(page: params[:page], per_page: 10)
    end  
  end

	def show
		@person = Person.find(params[:id])
    @score = current_user.scores.where(resource_id: @person.id).first || @person.scores.build if current_user
	end

	def new
		@person = Person.new
	end

	def edit
		@person = Person.find(params[:id])
    authorize @person
	end

	def create
		@person = Person.new(persons_params)
    @person.user_id = current_user.id
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
    authorize @person
		respond_to do |format|
			if @person.update_attributes(persons_params)
				format.html { redirect_to @person, notice: "Person successfully edited"}
			else
				format.html { render "edit" }
			end
		end
	end
  
  def destroy
    @person = Person.find(params[:id])
    authorize @person
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
		params.require(:person).permit(:name, :born, :died, :description, :portrait, :opened)
	end
end