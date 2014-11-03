class ContactMailer < ActionMailer::Base
  default to: "to@example.com"
  default from: "from@example.com"

  def contact_admin(user, content)
    @user = user
    @content = content
    mail(subject: "Site Contact Form(#{@user.name}) <#{@user.email}>")
  end
end
