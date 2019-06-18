class UsersController < ApplicationController
  
  # SignUp Form
  def new
    @user = User.new    
  end

# Show single user detail
  def show
    @user = User.find(params[:id])
  end

  # User list page
  def index
    @users = User.all
  end

# SignUp POST
  def create
    @user = User.new(user_params)

    if @user.save
        sign_in @user
        flash[:success] = "Welcome to the Stock price App!"
        SendGridMailer.send_welcome_mail(@user.email)
        redirect_to @user
    else
        render 'new'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted."
    redirect_to users_url
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end
end
