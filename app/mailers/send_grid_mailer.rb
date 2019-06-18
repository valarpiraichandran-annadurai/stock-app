class SendGridMailer < ApplicationMailer
  require 'sendgrid-ruby'
  include SendGrid

  def send_mail
    

    from = Email.new(email: 'test@example.com')
    to = Email.new(email: 'valarpiraichandran.annadurai@freshworks.com')
    subject = 'Sending with SendGrid is Fun'
    content = Content.new(type: 'text/plain', value: 'and easy to do anywhere, even with Ruby')
    mail = Mail.new(from, subject, to, content)

    sg = SendGrid::API.new(api_key: SENDGRID_CONFIG[:SENDGRID_API_KEY])
    response = sg.client.mail._('send').post(request_body: mail.to_json)
  end
end
