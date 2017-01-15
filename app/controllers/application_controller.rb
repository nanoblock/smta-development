class ApplicationController < ActionController::Base

  rescue_from CanCan::AccessDenied do |exception|
    flash[:alert] = 'TESTTESTTEST'
  end
  
  protect_from_forgery with: :exception
  before_action :browser_type
  before_action :set_search

  before_action :invalid_token_param, only: [:validation, :get_token]
  skip_before_filter :verify_authenticity_token, only: [:validation]
  skip_before_filter :require_no_authentication, only: [:validation]

  def browser_type
    @browser = set_browser_type
  end

  def set_search
    @search = Project.ransack(params[:q])

    @search_projects = @search.result.order('created_at DESC').page(params[:page]).per(6)
    search_users = Array.new
    @result = Hash.new
    
    unless @search_projects.nil?
      @search_projects.each do |projects|
        search_users << User.find(projects.user_id)
      end
    end

    @result = {project: @search_projects, user: search_users}

    @last_page = pagining(@search_projects.size)
    gon.projects = @result
  end

  # @token
  def validation
    token = Token.find_by_token(token_param) if token_param

    if !token
      return render nothing: true, status: :no_content
      # , json: {"status": "error", "message": "Not exsist token."}
    else
      return invalied_token_expired(token)
    end
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

  def token_param
    param = nil

    if request.headers[:HTTP_ACCESS_TOKEN]
      param = request.headers[:HTTP_ACCESS_TOKEN]
    elsif params[:oauth_token]
      param = params[:oauth_token]
    elsif params[:access_token]
      param = params[:access_token] 
    end
    param
  end

  def invalid_token_param
    return render status: 400, json: {"status": "error", "message": "Not exsist param access token."} unless request.headers[:HTTP_ACCESS_TOKEN] || params[:oauth_token] || params[:access_token]
  end

  def invalied_token_expired(token)
    return render status: 401, json: {"stauts": "error", "message": "This token is expired."} unless token.before_expired?
    @token = token
  end


end