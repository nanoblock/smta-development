class VideoController < ApplicationController
  before_action :validation, only: [:api_create]
  skip_before_filter :verify_authenticity_token, only: [:api_create]
  skip_before_filter :require_no_authentication, only: [:api_create]

  def create
    video = @project.videos.build(video_params)

    if video.save
      return render status: 200, json: video
    else
      return render nothing: true, status: 304
    end
  end

  def show

  end

  def update

  end

  def destroy

  end

  def api_create
    user = User.find @token.user_id
    @project = user.projects.build(project_params)
    
    video = Video.new(video_params)
    @project.video = video

    return render nothing: true, status: 304 unless @project.save
    return render status: 304 unless video.save

    return render status: :ok, json: video

  end


  private
  def video_params
    params.require(:video).permit(:url)
  end

  def project_params
    params.require(:project).permit(:name, :desc)
  end

  def set_project project_id
    id = params[:project_id] if params[:project_id]
    id = project_id if project_id

    return @project = Project.find(id) if id
    return @project = current_user.projects.find_by_name(params[:project_name]) if params[:project_name]
  end

end