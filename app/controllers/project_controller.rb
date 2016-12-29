class ProjectController < ApplicationController
  before_action :authenticate_user!, only: [:update, :show, :create]
  before_action :find_by_project_name, only: [:show, :update, :relation, :preview]

  def new
    @project = current_user.projects.new
    @project.name = ""
    @project.desc = ""
    @images = @project.images

  end

  def create
    @project = current_user.projects.build(project_params)
    if @project.save
      render status: 200, json: @project, nothing: true
    else
      render :new 
    end
  end

  def destroy

  end

  def destroy_all

  end

  def update
    @project.name = params[:project][:name]
    @project.desc = params[:project][:desc]

    if @project.save
      render nothing: true, status: :ok
    else
      render nothing: true, status: 304
    end
  end

  def show
    @images = @project.images.all
  end

  def relation
    @images = @project.images.all
    unless (params[:image_id]).nil?
      @image = Image.find(params[:image_id])
    else
      @image = @images.first
    end
    @image_id = @image.id
    render "project/relation"
  end

  def preview
    @images = @project.images.all
    unless (params[:image_id]).nil?
      @image = Image.find(params[:image_id])
    else
      @image = @images.first
    end
    render "project/preview"
  end

  def project_validate
    if Project.find_by_name(params[:project_name]).nil?
      render nothing: true, status: 200, json: {"message": "validate"}
    else
      render nothing: true, status: 226, json: {"message": "invalidate"}
    end
  end

  private
  def project_params
    params.require(:project).permit(:name, :desc)
  end

  def find_by_project_name
    if !params[:project_id].nil?
      return @project = current_user.projects.find(params[:project_id])
    else
      return @project = current_user.projects.find_by_name(params[:project_name])
    end


    # if current_user.projects.where(name: params[:project_name]).length <= 1
      
    # else
    #   @project = current_user.projects.find(params[:project_id])
    # end

    # unless @project.nil?
    #   return @project
    # else
    #   redirect_to root_path
    # end
  end

end