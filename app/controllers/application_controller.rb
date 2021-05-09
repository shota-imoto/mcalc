class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session
  around_action :switch_locale

  include JwtAuthentication
  include Locale

  def authenticate
    pp jwt_token
    if jwt_token.present?
      @user = User.find_or_initialize_by(uuid: payload[0]["sub"])
      @user.save! if @user.new_record?
    end
  end

  def switch_locale(&block)
    I18n.with_locale Locale::Check.new(params[:locale]).supported_locale, &block
  end

  private

  def payload
    JwtAuthentication::Decode.new(jwt_token).payload
  end

  def jwt_token
    request.authorization&.remove("Token ", "")
  end
end
