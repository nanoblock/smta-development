module ApplicationHelper
  def resource_name
    :user
  end
 
  def resource
    @resource ||= User.new
  end
 
  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

  # def current_user
  #   puts "******************************************"
  #   if session[:user_id].blank?
  #     puts "$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$"
  #     return @current_user ||= warden.authenticate(:scope => :user)
  #   else
  #     puts "******************************************"
  #     return @current_user ||= User.find(session[:user_id])
  #   end
  # end

  # def 
  #   controller.action_name
  # end

end
