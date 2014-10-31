module Api
  class GamesController < ApplicationController
    before_filter :require_signed_in, only: [:new, :create]
    before_filter :require_current_user_owner, only: [:edit, :update, :destroy]

    def index
      @games = Game.includes(:author).all
      render :index
    end

    def create
      @game = Game.new(game_params)
      if @game.save()
        render :show
      else
        render json: { error: @game.errors.full_messages }
      end
    end

    def show
      @game = Game.find(params[:id]);
      if @game
        render :show
      else
        render json: { error: "User not found!" }, status: 404
      end
    end

    def update
      @game = Game.new(game_params)
      if @game.save()
        render :show
      else
        render json: { error: @game.errors.full_messages }
      end
    end

    def destroy
      @game = Game.find(params[:id])
      @game.destroy
      render json: {}, status: 200;
    end

    private
    def game_params
      params.require(:game)
        .permit(:title, :subtitle, :source, :time_limit, :author_id)
    end

    def require_current_user_owner
      if !signed_in? || Game.find(params[:id]).author_id != current_user.id
        redirect_to games_url
      end
    end

  end
end
