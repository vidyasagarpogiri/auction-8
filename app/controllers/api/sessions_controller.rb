class Api::SessionsController < ApplicationController

  def create
    @user = User.find_by(username: session_params[:username])
    if @user
      login(@user)
      render :show
    else
      render json: ["Couldn't find user"], status: 401
    end
  end

  def destroy
    logout
    render json: {}
  end

  def session_params
    params.require(:user).permit(:username)
  end

end
