class SessionsController < ApplicationController
  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.find_by_credentials(
          params[:session][:email],
          params[:session][:password]
        )

    if @user
      login!(@user)
      # CHANGE THE REDIRECT LATER
      redirect_to new_user_url
    else
      flash.now[:errors] = ["invalid credentials"]
      @user = User.new(email: params[:session][:email])
      render :new
    end
  end

  def destroy
    logout!
    redirect_to new_session_url
  end
end
