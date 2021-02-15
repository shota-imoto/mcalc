module UserConfirmation
  require 'securerandom'

  def confirm_token
    user = User.find(params[:user_id])
    user.confirmation_token == params[:confirmation_token] && user.confirmation_sent_at + 30.minutes >= Time.zone.now
  end

  def confirmation_options
    {confirmation_token: confirmation_token, confirmation_sent_at: Time.zone.now}
  end

  private

  def confirmation_token(length = 20)
    rlength = (length * 3) / 4
    SecureRandom.urlsafe_base64(rlength)
  end
end
