class Users::SessionsController < Devise::SessionsController
# before_action :configure_sign_in_params, only: [:create]
  before_action :login_validataion, only: [:create]
  skip_before_filter :verify_authenticity_token, only: [:create]
  skip_before_filter :require_no_authentication, only: [:create]

  # after_action :cookie_info, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  def create
    # super
    self.resource = warden.authenticate!(auth_options)
    set_flash_message!(:notice, :signed_in)
    
    if resource
      user = resource
      sign_in(resource_name, resource)
    else
      user = User.find_by_email(params[:user][:email])
      sign_in(user, scope: :user) 
    end
    
    # profile = Profile.new
    # user.profile = profile
    # profile.save

    yield resource if block_given?
    render status: :ok, json: {"user": user, "token": user.token(user.id)}
    # respond_with resource, location: after_sign_in_path_for(resource)
  end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end

  def login_by_token

  end

  def login_validataion
    resource = User.find_for_database_authentication(email: params[:user][:email])
    return invalid_login_email unless resource
    return invalid_login_attempt unless resource.valid_password?(params[:user][:password])
  end

  protected
  def invalid_login_email
    set_flash_message(:alert, :invalid_email)
    # render json: flash[:alert], status: 401
    render status: 401, json: {"status": "error", "message": flash[:alert]}
  end

  def invalid_login_attempt
    set_flash_message(:alert, :invalid)
    # render json: flash[:alert], status: 401
    render status: 401, json: {"status": "error", "message": flash[:alert]}
  end

end
