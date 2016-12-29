class ApplicationController < ActionController::Base

  rescue_from CanCan::AccessDenied do |exception|
    flash[:alert] = 'TESTTESTTEST'
  end
  
  protect_from_forgery with: :exception
  before_action :browser_type
  before_action :set_search

  def browser_type
    @browser = set_browser_type
  end

  def set_search
    @search = Project.ransack(params[:q])

    @search_projects = @search.result.order('created_at DESC').page(params[:page]).per(6)
    search_users = Array.new
    @result = Hash.new
    puts "!@!@!@!@!@!@!@!@!@!@!@!@!@!@!@!@!@!@!@!@!@"
    p @search_projects.size
    puts "!@!@!@!@!@!@!@!@!@!@!@!@!@!@!@!@!@!@!@!@!@"
    unless @search_projects.nil?
      @search_projects.each do |projects|
        search_users << User.find(projects.user_id)
      end
    end

    @result = {project: @search_projects, user: search_users}

    @last_page = pagining(@search_projects.size)
    
  end

  private
  def set_browser_type
    # return request.variant = :desktop
    return request.variant = :tablet if browser.device.tablet?
    return request.variant = :phone if browser.device.mobile?
    return request.variant = :desktop if !browser.device.mobile? && !browser.device.tablet?
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