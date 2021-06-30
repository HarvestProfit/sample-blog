# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview
  def user
    UserMailer.welcome_to_blog_email(User.first)
  end
end
