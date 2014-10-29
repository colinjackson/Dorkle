class UsersController < ApplicationController

  def new
    @user = User.new()
    render :new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = ["Welcome to Dorkle!"]
      sign_in!(user)
      redirect_to user_url(@user)
    else
      flash.now[:errors] = ["Zoinks!"] + @user.errors.full_messages
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
    render :show
  end

  def edit
    @user = User.find(params[:id])
    render :edit
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = ["You've successfully updated your account! Happy Dorkling!"]
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
    params.require(:user).permit(:username, :email, :name, :password)
  end

end
