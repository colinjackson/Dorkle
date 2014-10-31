module Api
  class UsersController < ApplicationController

    def show
      @user = User.includes(:created_games).find(params[:id])
      render :show
    end

  end
end
