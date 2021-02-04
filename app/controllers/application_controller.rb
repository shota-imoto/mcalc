class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session
  include JwtAuthentication

  before_action :configure_permitted_parameters, if: :devise_controller?

  def user_confirmed?
    if user_signed_in?
      redirect_to new_user_confirmation_path if current_user.confirmed?
    end
  end

  def authenticate
    jwt_token = request.authorization&.remove("Token ", "")
    return unless jwt_token

    payload = decode(jwt_token)
    @user = User.find(payload[0]["sub"])
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname])
  end
end
