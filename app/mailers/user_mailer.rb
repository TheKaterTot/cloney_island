class UserMailer < ApplicationMailer
default from: "cloneyislandmailer@gmail.com"

  def welcome_email(user)
    @user = user
    mail(to: @user.email, subject: 'Welcome to Stack')
  end

  def blocked_email(user)
    @user = user
    mail(to: @user.email, subject: "Ban Notice")
  end
end
