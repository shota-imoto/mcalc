class Api::V1::Users::PasswordController < ApplicationController
  require 'securerandom'
  include UrlHelper

  def reset
    binding.pry
    user = User.find_by(email: params[:user][:email])
    if user
      user.update(sign_up_params)
      UserMailer.reset_password(user).deliver_now
      registration_response = Response.new(status: 'success', message: 'mail for confirmation has sent', user_id: user.id)
    else
      registration_response = Response.new(status: 'error', message: 'そのメールアドレスは登録されていません')
    end
    serializer = ResponseSerializer.new(registration_response)
    render json: serializer.serializable_hash.to_json
  end

  def confirm
    binding.pry
    # token = params[:confirmation_token]
    # if token
    #   user = User.find(params[:user_id])
    #   result = user.confirm_token(token)
    #   url = app_url_with_params(result)
    #   redirect_to url
    # else
    #   render plain: "不正なアクセス"
    # end
  end

  private

  def sign_up_params
    params.require(:user).permit(:email).merge(confirmation_options)
  end

  def confirmation_options
    { reset_password_token: confirmation_token, reset_password_sent_at: Time.zone.now }
  end

  def confirmation_token(length = 20)
    rlength = (length * 3) / 4
    SecureRandom.urlsafe_base64(rlength)
  end
end
