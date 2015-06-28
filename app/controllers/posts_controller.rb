class PostsController < ApplicationController
  before_action :set_resource, only: [ :edit, :create, :update, :destroy]
  before_filter :set_topic, only: [:create, :edit, :update, :destroy]
  
  def create
    @post = @topic.posts.build(post_params)
    
    respond_to do |format|
      if @post.save
        format.html { redirect_to topic_show_path(@topic), notice: "Post successfuly added"}
      else
        format.html { redirect_to topic_show_path(@topic), alert: @post.errors}
      end
    end
  end
  
  def edit
    @post = @topic.posts.find(params[:id])
    authorize @post
  end
  
  def update
    @post = @topic.posts.find(params[:id])
    authorize @post
    
    respond_to do |format|
      if @post.update_attributes(post_params)
        format.html { redirect_to topic_show_path(@topic), notice: "Post successfuly updated"}
      else
        format.html { redirect_to topic_show_path(@topic), alert: @post.errors}
      end
    end
  end
  
  def destroy
    @post = @topic.posts.find(params[:id])
    authorize @post
    
    @post.destroy
    
    respond_to do |format|
      format.html { redirect_to redirect_to topic_show_path(@topic), notice: "Post successfuly deleted"}
    end
  end
  
  private
  
  def set_topic
    @topic = Topic.find(params[:topic_id])
  end
  
  def post_params
    params.require(:post).permit(:content)
  end
  
  def topic_show_path(topic)
    case topic.subject.class.name
    when "Movie"
      return movie_topic_path(@resource, topic)
    when "Person"
      return person_topic_path(@resource, topic)
    end
  end
  
  def set_resource
    if params[:movie_id].blank?
      @resource = Person.find(params[:person_id])
    elsif params[:person_id].blank?
      @resource = Movie.find(params[:movie_id])
    end
  end
end