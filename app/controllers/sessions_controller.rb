class SessionsController < ApplicationController

  def new

  end

  def create
    user = User.find_by_credentials(session_params[:email], session_params[:password])
    if user
      login(user)
      redirect_to user_url(user)
    else
      flash.now[:errors] = ["Invalid login"]
      render :new
    end
  end

  def destroy
    logout
    redirect_to new_session_url
  end

  private

  def session_params
    params.require(:sessions).permit(:email, :password)
  end

end
