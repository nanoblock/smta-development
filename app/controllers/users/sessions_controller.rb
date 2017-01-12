class Users::SessionsController < Devise::SessionsController
# before_action :configure_sign_in_params, only: [:create]
  before_action :login_validataion, only: [:create]
  # after_action :cookie_info, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

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
    render json: flash[:alert], status: 401
  end

  def invalid_login_attempt
    set_flash_message(:alert, :invalid)
    render json: flash[:alert], status: 401
  end

end
