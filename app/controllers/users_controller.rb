class UsersController < ApplicationController

  def new

  end

  def create
    @user = User.new(user_params)
    if @user.save
      login(@user)
      redirect_to user_url(@user)
    else
      flash.now[:errors] = @user.errors.full_messages
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
    if @user == current_user  
      render :show
    else
      redirect_to root_url
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :username, :password)
  end

end
