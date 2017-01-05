class UsersController < ApplicationController
  before_action :find_user, only: [:edit, :update, :destroy]
  def index
    @users = User.all.paginate(:page => params[:page], per_page: 5)
    @user = User.new
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to_index
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to_index
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    redirect_to_index
  end

  private

  def user_params
    params.require(:user).permit(:name)
  end

  def find_user
    @user = User.find(params[:id])
  end

  def redirect_to_index
    redirect_to users_path
  end
end
