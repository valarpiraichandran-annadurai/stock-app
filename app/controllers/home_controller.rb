class HomeController < ApplicationController


  def index
    
  end

  def show
  end

  def send_mail
    SendWelcomeEmailJob.perform_now(nil)

    redirect_to root_url
  end
end
