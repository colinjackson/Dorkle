class UsersController < ApplicationController
  before_filter :require_signed_out, only: [:new, :create]
  before_filter :require_current_user, only: [:edit, :update, :destroy]

  def new
    @user = User.new()
    render :new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:successes] = ["Welcome to Dorkle!"]
      sign_in!(@user)
      redirect_to user_url(@user)
    else
      flash.now[:errors] = ["Zoinks!"] + @user.errors.full_messages
      render :new
    end
  end

  def show
    @user = User.includes(:created_games).find(params[:id])
    render :show
  end

  def edit
    @user = User.find(params[:id])
    render :edit
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:successes] =
        ["You've successfully updated your account! Happy Dorkling!"]
      redirect_to user_url(@user)
    else
      flash[:errors] = @user.errors.full_messages
      render :edit
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to new_user_url
  end

  private
  def user_params
    params.require(:user).permit(:username, :email, :name, :password, :image)
  end

  def require_current_user
    if !signed_in? || User.find(params[:id]) != current_user
      render plain: "You are a bad person!", status: :forbidden
    end
  end

end
