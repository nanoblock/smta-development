class ProfileController < ApplicationController
  before_action :authenticate_user!, only: [:show, :update]
  before_action :set_profile, only: [:show, :update]
  before_action :set_project, only: [:show]

  def create
    @profile = Profile.new(profile_avatar_params)
    current_user.profile = @profile

    if @profile.save
      render nothing: true, status: :ok
    else
      render nothing: true, status: :bad_request
    end
  end

  def show
    @last_page = pagining(@projects.size)
    @projects = @projects.order('created_at DESC').page(params[:page]).per(4)
  end

  def update
    @profile.app_name = params[:profile][:app_name]
    @profile.desc = params[:profile][:desc]
    @profile.tel = params[:profile][:tel]
    @profile.app_email = params[:profile][:app_email] 
    @profile.avatar = params[:profile][:avatar]

    if @profile.save
      current_user.profile = @profile
      render nothing: true, json: @profile, status: :ok
    else
      render nothing: true, status: 304
    end
  end

  private
  def set_profile
    @profile = current_user.profile
    if @profile.nil?
      @profile        = Profile.new
      gon.app_name    = "어플 이름"
      gon.desc        = "수정 버튼을 눌러 어플에 대한 정보를 입력하세요."
      gon.tel         = "전화번호"
      gon.app_email   = "이메일"
    end
    return @profile
  end

  def set_project
    return @projects = current_user.projects.all
  end

  def profile_params
    params.require(:profile).permit(:app_name, :desc, :tel, :app_email)
  end

  def profile_avatar_params
    params.require(:profile).permit(:avatar, :app_name, :desc, :tel, :app_email)
  end

  def pagining length
    @last_page = (length) % 4

    unless @last_page.zero?
      @last_page = (length / 4) + 1
    else
      @last_page = (length / 4)
    end
    
    @last_page
  end

end