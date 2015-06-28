class ReviewsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_movie
  
  def index
    @reviews = @movie.reviews
  end
  
  def show
    @review = @movie.reviews.find(params[:id])
  end
  
  def new
    @review = current_user.reviews.build
  end
  
  def create
    @review = current_user.reviews.build(reviews_params)
    authorize @review
    @review.movie = @movie
    
    respond_to do |format|
      if @review.save
        format.html { redirect_to movie_review_path(@movie, @review), notice: "Review created"}
      else
        format.html { render action: "new", alert: @review.errors}
      end
    end
  end
  
  def edit
    @review = @movie.reviews.find(params[:id])
    authorize @review
  end
  
  def update
    @review = @movie.reviews.find(params[:id])
    authorize @review
    
    respond_to do |format|
      if @review.update_attributes(reviews_params)
        format.html { redirect_to movie_reviews_path(@movie, @review), notice: "Review updated"}
      else
        format.html { render action: "edit", alert: @review.errors}
      end
    end
  end
  
  def destroy
    @review = @movie.reviews.find(params[:id])
    authorize @review
    @review.destroy
    
    respond_to do |format|
      format.html { redirect_to movie_path(@movie), notice: "Review successfuly deleted"}
    end
  end
  
  private
  
  def reviews_params
    params.require(:review).permit(:movie_id, :user_id, :content, :title)
  end
  
  def set_movie
    @movie = Movie.find(params[:movie_id])
  end

end