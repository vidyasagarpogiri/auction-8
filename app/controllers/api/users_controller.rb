class Api::UsersController < ApplicationController

  before_action :ensure_not_logged_in, only: [:create]
  before_action :ensure_correct_user, only: [:show]

  def show
    @user = User.find_by(id: params[:id])
  end

  def create
    @user = User.new(user_params)
    if @user.save
      login(@user)
      render :show
    else
      @errors = @user.errors.full_messages
      render json: @errors, status: 422
    end
  end

  def user_params
    params.require(:user).permit(:username)
  end

end
