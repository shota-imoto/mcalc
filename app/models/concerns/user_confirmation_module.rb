module UserConfirmationModule
  extend ActiveSupport::Concern

  def confirm_token(token)
    return errors.add(:confirmed_at, :registration_complete) && false if registration_complete?
    return errors.add(:confirmation_sent_at, :token_expiration) && false if expired?
    return errors.add(:confirmation_token, :uncorresponded_token) && false unless is_correct_token?(token)
    complete_confirmation
  end

  private

  def registration_complete?
    confirmed_at.present?
  end

  def expired?
    self.confirmation_sent_at + 30.minutes < Time.zone.now
  end

  def is_correct_token?(token)
    self.confirmation_token == token
  end

  def complete_confirmation
    confirmed_at = Time.zone.now
    save validate: false
  end
end
