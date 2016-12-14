class ProjectController < ApplicationController
  before_action :authenticate_user!, only: [:new, :update, :show]
  before_action :find_by_project_name, only: [:show, :update]

  def new
    @project = current_user.projects.new
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
    unless params[:project_name].nil?
      @images = @project.images.all
    end
  end

  private
  def project_params
    params.require(:project).permit(:name, :desc)
  end

  def find_by_project_name
    return @project = current_user.projects.find_by_name(params[:project_name])
  end

end