
class ProjectController < ApplicationController
  before_action :authenticate_user!, only: [:update, :show, :create, :relation]
  before_action :set_project, only: [:show, :update, :relation, :preview]

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
      render nothing: true, status: 304
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
    gon.param = params[:project_id]
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
    puts "$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$"
    puts "project id -> #{@project.id}"
    puts "$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$"
    @project_manager = gon.project_manager = project_manager? @project.id unless @project.id.nil?

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

  def set_project
    id = params[:project_id]
    return @project = current_user.projects.find(id) if id
    return @project = current_user.projects.find_by_name(params[:project_name]) if params[:project_name]
  end

  def project_manager? project_id
    # preview mode true   -> guest
    # preview mode false  -> manager
    return false if !user_signed_in?

    current_project = Project.find(project_id)
    current_user.projects.each do |projects|
      return true if current_project == projects
    end

    return false
  end

end