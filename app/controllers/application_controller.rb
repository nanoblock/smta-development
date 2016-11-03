class ApplicationController < ActionController::Base

  rescue_from CanCan::AccessDenied do |exception|
    flash[:alert] = 'TESTTESTTEST'
  end
  
  protect_from_forgery with: :exception
  before_action :browser_type

  def browser_type
    @browser = set_browser_type
  end

  private
  def set_browser_type
    return request.variant = :phone if browser.device.mobile?
    return request.variant = :tablet if browser.device.tablet?
    return request.variant = :desktop if !browser.device.mobile? && !browser.device.tablet?
  end
end