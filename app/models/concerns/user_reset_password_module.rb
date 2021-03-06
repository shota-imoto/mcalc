module UserResetPasswordModule
  extend ActiveSupport::Concern

  def confirm_reset_password_token(token)
    if check_reset_password_expiration
      errors.add(:reset_password_sent_at, :token_expiration) && false
    elsif check_reset_password_token(token)
      true
    else
      errors.add(:reset_password_token, :not_correspond) && false
    end
  end

  private

  def check_reset_password_expiration
    reset_password_sent_at + 30.minutes < Time.zone.now
  end

  def check_reset_password_token(token)
    self.reset_password_token == token
  end
end
