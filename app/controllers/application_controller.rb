class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session
  include JwtAuthentication

  def authenticate
    jwt_token = request.authorization&.remove("Token ", "")
    if jwt_token.present?
      payload = decode(jwt_token)
      @user = User.find(payload[0]["sub"])
    end
  end
end
