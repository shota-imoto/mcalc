class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session
  around_action :switch_locale

  include JwtAuthentication
  include Locale

  def authenticate
    jwt_token = request.authorization&.remove("Token ", "")
    if jwt_token.present?
      payload = decode(jwt_token)
      @user = User.find_or_initialize_by(uuid: payload[0]["sub"])
      @user.save! if @user.new_record?
    end
  end

  def switch_locale(&block)
    I18n.with_locale Locale::Check.new(params[:locale]).supported_locale, &block
  end
end
