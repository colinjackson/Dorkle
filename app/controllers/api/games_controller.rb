module Api
  class GamesController < ApplicationController
    before_filter :require_signed_in, only: [:new, :create]
    before_filter :require_current_user_owner, only: [:edit, :update, :destroy]
    wrap_parameters false

    def index
      @games = Game.includes(:author).with_answers.last(10)
      render :index
    end

    def create
      @game = current_user.created_games.new(game_params)

      unless !game_answers_params
        game_answers_params.each do |answer_params|
          @game.answers.new(answer_params.permit(:answer))
        end
      end

      if @game.save()
        render :show
      else
        render json: { error: @game.errors.full_messages }, status: :unprocessable_entity
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
      @game = Game.find(params[:id])
      if @game.update(game_params)
        render :show
      else
        render json: { error: @game.errors.full_messages }, status: :unprocessable_entity
      end
    end

    def destroy
      @game = Game.find(params[:id])
      @game.destroy
      render json: {}
    end

    private
    def game_params
      params.require(:game)
        .permit(:title, :subtitle, :source, :time_limit, :image)
    end

    def game_answers_params
      params.require(:game)['answers']
    end

    def require_current_user_owner
      if !signed_in? || Game.find(params[:id]).author_id != current_user.id
        redirect_to games_url
      end
    end

  end
end
