class TokenController < ApplicationController
  before_action :invalid_token_param, only: [:validation]

  def validation
    token = Token.find_by_token(params[:token])
    if token
      return render status: 204, json: {"status": "error", "message": "Not exsist token."} unless token
    else
      return token_validation(token)
    end
  end

  private

  def invalid_token_param
    return render status: 400, json: {"status": "error", "message": "Not exsist token param."} if params[:token].nil?
  end

  def token_validation(token)
    if token.before_expired?
      render status: :ok, json: {"status": "success", "data": {"token": token}}
    else
      render status: 401, json: {"stauts": "error", "message": "This token is expired."}
    end
  end

end