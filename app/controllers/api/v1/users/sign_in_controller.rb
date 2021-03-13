class Api::V1::Users::SignInController < ApplicationController
  protect_from_forgery :except => [:create]

  def create
    user = User.find_by(email: user_params[:email])
    if user&.authenticate(user_params[:password])
      jwt_token = issue(user.id)
      response.headers['X-Authentication-Token'] = jwt_token

      session_response = Response.new(status: 'success', message: "signed in as #{user.nickname}", user_id: user.id)
      serializer = ResponseSerializer.new(session_response)
      render json: serializer.serializable_hash.to_json
    else
      message = 'メールアドレスまたはパスワードが間違っています'
      session_response = Response.new(status: 'error', message: message)
      serializer = ResponseSerializer.new(session_response)
      render json: serializer.serializable_hash.to_json
    end
  end

  protected

  def user_params
    params.require(:user).permit(:email, :password)
  end
end
