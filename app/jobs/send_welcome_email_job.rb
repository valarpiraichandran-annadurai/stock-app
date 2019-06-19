class SendWelcomeEmailJob < ActiveJob::Base
  queue_as :default

  def perform(user_email)
    # Do something later
    if user_email.nil?
      SendGridMailer.send_welcome_mail(user_email)
    else
      SendGridMailer.send_mail
    end
  end
end
