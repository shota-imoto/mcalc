class Api::V1::Users::PasswordsController < ApplicationController
  require 'securerandom'
  include UrlHelper

  def reset
    user = User.find_by(email: params[:user][:email])
    if user
      user.assign_attributes(sign_up_params)
      user.save validate: false
      UserMailer.reset_password(user).deliver_now
      registration_response = Response.new(status: 'success', message: 'mail for confirmation has sent', user_id: user.id)
    else
      registration_response = Response.new(status: 'error', message: 'そのメールアドレスは登録されていません')
    end
    serializer = ResponseSerializer.new(registration_response)
    render json: serializer.serializable_hash.to_json
  end

  def edit
    # binding.pry
    if params[:reset_password_token]
      user = User.find(params[:user_id])
      url = url_with_params('firecountdownapp://reset_password', reset_password_auth_params)
      redirect_to url
    else
      render plain: "不正なアクセス"
    end
  end

  def update
    user = User.find(params[:user][:user_id])
    if user
      if user.confirm_reset_password_token(params[:user][:reset_password_token])
        user.assign_attributes(reset_password_params)
        if user.save
          response = Response.new(status: 'success', message: 'password has changed')
        else
          response = Response.new(status: 'error', message: user.errors.full_messages)
        end
      else
        response = Response.new(status: 'error', message: user.errors.full_messages)
      end
      serializer = ResponseSerializer.new(response)
      render json: serializer.serializable_hash.to_json
    end
  end

  private

  def sign_up_params
    params.require(:user).permit(:email).merge(confirmation_options)
  end

  def reset_password_params
    params.require(:user).permit(:password, :password_confirmation)
  end

  def reset_password_auth_params
    { user_id: params[:user_id], reset_password_token: params[:reset_password_token] }
  end

  def confirmation_options
    { reset_password_token: confirmation_token, reset_password_sent_at: Time.zone.now }
  end

  def confirmation_token(length = 20)
    rlength = (length * 3) / 4
    SecureRandom.urlsafe_base64(rlength)
  end
end
