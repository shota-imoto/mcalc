class UserMailer < ApplicationMailer

  def confirm_sign_up(user)
    @user = user
    mail(
      from: "hideyoshi.playing.the.banjo@gmail.com",
      subject: "【F.I.R.E Countdown App】登録確認メール",
      to: @user.email
    ) do |format|
      format.text
    end
  end
end
