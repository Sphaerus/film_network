class ScoresController < ApplicationController
  
  def create
    @score = current_user.scores.build(score_params)
    
    respond_to do |format|
      if @score.save
        format.json { render json: true }
      else
        format.json { render json: false }
      end
    end
  end
  
  def update
    @score = Score.find(params[:id])
    
    respond_to do |format|
      if @score.update_attributes(score_params)
        format.json { render json: true }
      else
        format.json { render json: false }
      end
    end
  end
  
  private
  
  def score_params
    params.require(:score).permit(:score, :resource_type, :resource_id)
  end
end