class Users::PasswordsController < Devise::PasswordsController
  # GET /resource/password/new
  # def new
  #   super
  # end

  # POST /resource/password
  def create
    self.resource = resource_class.send_reset_password_instructions(resource_params)
    yield resource if block_given?

    if successfully_sent?(resource)
      @email = resource.email
      render :done
      # respond_with(resource, location: after_sending_reset_password_instructions_path_for(resource))
    else
      respond_with(resource)
    end
  end

  def done
  end

  # GET /resource/password/edit?reset_password_token=abcdef
  def edit
    super
  end

  # def valid_reset_token
  #   if User.find_by_reset_password_token params[:reset_password_token].nil?
      
  #   end
  # end

  # PUT /resource/password
  def update
    self.resource = resource_class.reset_password_by_token(resource_params)
    yield resource if block_given?

    if resource.errors.empty?
      resource.unlock_access! if unlockable?(resource)
      if Devise.sign_in_after_reset_password
        flash_message = resource.active_for_authentication? ? :updated : :updated_not_active
        set_flash_message!(:notice, flash_message)
        resource.after_password_reset
        sign_in(resource_name, resource)
      else
        set_flash_message!(:notice, :updated_not_active)
      end
      respond_with resource, location: after_resetting_password_path_for(resource)
    else
      set_minimum_password_length
      session[:return_to] ||= request.referer
      redirect_to session.delete(:return_to)
      # render :edit
    end
    
    # self.resource = resource_class.reset_password_by_token(params[resource_name])

    # if resource.errors.empty?
    #   set_flash_message(:notice, :updated) if is_navigational_format?
    #   sign_in(resource_name, resource)
    #   respond_with resource, :location => redirect_location(resource_name, resource)
    # else
    #   respond_with_navigational(resource){ render :edit }
    # end
  end

  # protected

  # def after_resetting_password_path_for(resource)
  #   super(resource)
  # end

  # The path used after sending reset password instructions
  # def after_sending_reset_password_instructions_path_for(resource_name)
  #   super(resource_name)
  # end

end
