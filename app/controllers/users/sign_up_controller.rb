class Users::SignUpController < ApplicationController
  include UserConfirmation

  def index
    if confirm_token
      jwt_token = issue(params[:user_id])
      response.headers['X-Authentication-Token'] = jwt_token
      redirect_to "firecountdownapp://home"
    else
      render plain: "不正なアクセス"
    end
  end
end
