module UserConfirmationModule
  extend ActiveSupport::Concern

  def confirm_token(token)
    return completed_params if confirmed_at.present?
    return expired_params if check_expiration

    if check_token(token)
      complete_confirmation
      correspond_params
    else
      not_correspond_params
    end
  end

  private

  def check_expiration
    self.confirmation_sent_at + 30.minutes < Time.zone.now
  end

  def check_token(token)
    self.confirmation_token == token
  end

  def complete_confirmation
    confirmed_at = Time.zone.now
    save validate: false
  end

  def completed_params
    { status: 'success', message: 'すでに本登録が完了しています' }
  end

  def expired_params
    { status: 'error', message: '登録確認メールの期限が切れています' }
  end

  def correspond_params
    { status: 'success', message: '本登録が完了しました。登録したメールアドレスとパスワードを入力してログインしてください' }
  end

  def not_correspond_params
    { status: 'error', message: '登録確認トークンが一致しません' }
  end
end
