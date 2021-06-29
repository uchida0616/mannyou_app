class UsersController < ApplicationController
  skip_before_action :login_required, only: [:new, :create]
  before_action :ensure_correct_user, only: [:show]

  def new
    redirect_to user_path(current_user.id) if logged_in?
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to user_path(@user.id), notice: "アカウントを作成しました！"
    else
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def ensure_correct_user
  	if @current_user.id != params[:id].to_i
  		redirect_to tasks_path, notice: "権限がありません。"
    end
	end
end
