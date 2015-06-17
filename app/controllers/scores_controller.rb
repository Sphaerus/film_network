class ScoresController < ApplicationController
  
  def score
    @score = current_user.scores.where(resource_id: params[:score][:resource_id], resource_type: params[:score][:resource_type]).first || current_user.scores.build(score_params)
    if !@score.new_record?
      @score.assign_attributes(score_params)
    end  

    @score.save
    respond_to do |format|
      format.json {render json: true}
    end
  end
  
  private
  
  def score_params
    params.require(:score).permit(:score, :resource_type, :resource_id)
  end
end