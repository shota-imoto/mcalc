module MailerHelper
  def url_with_confirmation_token(url, user)
    url.concat("?user_id=#{user.id}&confirmation_token=#{user.confirmation_token}")
  end
end
