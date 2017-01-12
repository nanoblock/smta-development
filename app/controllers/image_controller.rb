class ImageController < ApplicationController
  before_action :set_project, only: [:new, :create, :update, :destroy, :destroy_all]

  def new
    @image = @project.images.new
  end

  def create
    @image = @project.images.build(image_params)

    if @image.save
      render status: 200, json: @image
    else
      render nothing: true, status: 304
    end
  end

  def update
    # @image = @project.images.find(params[:image_id])
    # @image.xml_path = params[:xml_path]
    @image = @project.images.build(image_params)
    if @image.save
      render nothing: true, status: :ok, json: {"project": @project, "image": @image}
    else
      render nothing: true, status: 304
    end
  end

  def destroy
    @image = @project.images.find(params[:image_id])

    @image.destroy
    render nothing: true
  end

  def destroy_all
    @images = @project.images

    unless @images.nil?
      @images.each(&:destroy)
    end
    render nothing: true
  end

  private
  def image_params
    params.require(:image).permit(:photo)
  end

  def set_project
    id = params[:project_id]
    return @project = Project.find(id) if id
    return @project = current_user.projects.find_by_name(params[:project_name]) if params[:project_name]
  end

end