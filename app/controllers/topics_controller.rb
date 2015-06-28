class TopicsController < ApplicationController
  before_action :authenticate_user!, except: [:show]
  before_action :set_resource, only: [:new, :show, :edit, :create, :update, :destroy]
  before_action :set_topic, only: [:show, :edit, :update, :destroy]

  def show
    @post = @topic.posts.build
  end

  def new
    @topic = Topic.new
  end
  
  def edit
    authorize @topic
  end
  
  def create
    @topic = @resource.topics.build(topic_params)
    @topic.user_id = current_user.id
    authorize @topic

    respond_to do |format|
      if @topic.save
        format.html { redirect_to topic_show_path(@topic), notice: "Topic successfully created"}
      else
        format.html { render "new", alert: @topic.errors }
      end
    end
  end
  
  def update
    authorize @topic
    respond_to do |format|
      if @topic.update_attributes(topic_params)
        format.html { redirect_to topic_show_path(@topic), notice: "Topic successfully updated"}
      else
        format.html { render "edit", alert: @topic.errors }
      end
    end
  end
  
  def destroy
    authorize @topic
    @topic.destroy
    
    respond_to do |format|
      format.html { redirect_to @resource, notice: "Topic successfully deleted"}
    end
  end
  
  private
  
  def set_resource
    if params[:movie_id].blank?
      @resource = Person.find(params[:person_id])
    elsif params[:person_id].blank?
      @resource = Movie.find(params[:movie_id])
    end
  end
  
  def set_topic
    @topic = @resource.topics.find(params[:id])
  end
  
  def topic_show_path(topic)
    case topic.subject.class.name
    when "Movie"
      return movie_topic_path(@resource, topic)
    when "Person"
      return person_topic_path(@resource, topic)
    end
  end
  
  def topic_params
    params.require(:topic).permit(:title, :content, :subject_id, :subject_type)
  end
  
end
