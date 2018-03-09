class ChatbotMailer < ActionMailer::Base
  default from: "aichatbot@mail.com"

  def set_password(user, token)
    @user = user
    @token = token
    mail(to: @user.email, subject: t('.mail_subject'))
  end
end