class Api::V1::Users::SignUpController < ApplicationController
  require 'securerandom'
  include UrlHelper

  def create
    user = User.new(sign_up_params)
    if user.save
      UserMailer.confirm_sign_up(user).deliver_now
      registration_response = Response.new(status: 'success', message: 'mail for confirmation has sent', user_id: user.id)
    else
      registration_response = Response.new(status: 'error', message: user.errors.full_messages)
    end
    serializer = ResponseSerializer.new(registration_response)
    render json: serializer.serializable_hash.to_json
  end

  def confirm
    if params[:confirmation_token]
      user = User.find(params[:user_id])
      if user.confirm_token(params[:confirmation_token])
        url = app_url_with_params(status: 'success', message: '本登録が完了しました。登録したメールアドレスとパスワードを入力してログインしてください')
      else
        url = app_url_with_params(status: 'error', message: user.errors.full_messages)
      end
      redirect_to url
    else
      render plain: "不正なアクセス"
    end
  end

  private

  def sign_up_params
    params.require(:user).permit(:nickname, :email, :password, :password_confirmation).merge(confirmation_options)
  end

  def confirmation_options
    { confirmation_token: confirmation_token, confirmation_sent_at: Time.zone.now }
  end

  def confirmation_token(length = 20)
    rlength = (length * 3) / 4
    SecureRandom.urlsafe_base64(rlength)
  end
end
