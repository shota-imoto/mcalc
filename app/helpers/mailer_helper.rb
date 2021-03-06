module MailerHelper
  def url_with_confirmation_token(url, user)
    additional_url = confirmation_params(user).inject("?") { |url, (k, v)| url += "#{k}=#{v}&" }
    url.concat(additional_url)
  end

  def url_with_reset_password_token(url, user)
    additional_url = reset_password_params(user).inject("?") { |url, (k, v)| url += "#{k}=#{v}&" }
    url.concat(additional_url)
  end

  def confirmation_params(user)
    {
      user_id: user.id,
      confirmation_token: user.confirmation_token
    }
  end

  def reset_password_params(user)
    {
      user_id: user.id,
      reset_password_token: user.reset_password_token
    }
  end
end
