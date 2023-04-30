class UserMailer < ApplicationMailer
	# メールの送信元のアドレスを指定する
  default from: 'from@example.com'

	# 実際にメールを送るメソッド
  def reset_password_email(user)
    @user = User.find(user.id)

		# このURLでパスワードリセット画面にアクセスできる
    @url = edit_password_reset_url(@user.reset_password_token)

		# ユーザーのメールアドレスと件名を指定する
    mail(to: user.email, subject: t('defaults.password_reset'))
  end
end