class Api::V1::Users::SignUpController < ApplicationController
  include UserConfirmation
  protect_from_forgery :except => [:create]

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
    if confirm_token
      redirect_to "firecountdownapp://home"
    else
      render plain: "不正なアクセス"
    end
  end

  protected

  def sign_up_params
    params.require(:user).permit(:nickname, :email, :password, :password_confirmation).merge(confirmation_options)
  end
end
