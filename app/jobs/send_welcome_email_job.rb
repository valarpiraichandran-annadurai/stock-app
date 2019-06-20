class SendWelcomeEmailJob < ActiveJob::Base
  queue_as :default

  def perform(user_email)
    # Do something later
    puts "Job: Send Welcome email to #{user_email}"

    SendGridMailer.send_welcome_mail(user_email).deliver_now
  end
end
