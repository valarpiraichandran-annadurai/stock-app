class HomeController < ApplicationController


  def index
    
  end

  def show
  end

  def send_mail
    SendGridMailer.send_mail

    redirect_to root_url
  end
end
