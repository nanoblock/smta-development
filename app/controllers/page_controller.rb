class PageController < ApplicationController
  def landing
    redirect_to project_search_path if user_signed_in?
  end
  def home
  end
  def privacy
  end
  def term
  end
  def reset_password
  end

  def test
  end
end
