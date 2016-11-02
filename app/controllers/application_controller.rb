class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
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