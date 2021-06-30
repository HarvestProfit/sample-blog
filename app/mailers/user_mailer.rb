class UserMailer < ApplicationMailer
  def welcome_to_blog_email(user)
    @user = user
    mail(to: @user.email, subject: 'Welcome to the Harvest Profit Blog API!')
  end
end
