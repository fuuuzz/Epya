class Notifier < ActionMailer::Base
  default from: "contact@epya.herokuapp.com"
  
  def news_email(user)
    @user = user
    mail(to: @user.email, subject: 'A news has been sended from a project that you are following')
  end
end
