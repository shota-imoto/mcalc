module MailerHelper
  def url_with_confirmation_token(url, user)
    additional_url = additional_params(user).inject("?") { |url, (k, v)| url += "#{k}=#{v}&" }
    url.concat(additional_url)
  end

  def additional_params(user)
    {
      user_id: user.id,
      confirmation_token: user.confirmation_token
    }
  end
end
