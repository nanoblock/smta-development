class ProfileController < ApplicationController
  # before_action :check_profile_presence, only: [:new, :create]

  def new

  end

  def create

  end

  def show
    
  end

  private
  def profile_params
    params.require(:profile).permit(:app_name, :desc, :tel, :app_email)
  end
  # def check_profile_presence
  #   redirect_to user_profile_path if current_user.profile.exists?
  # end

end