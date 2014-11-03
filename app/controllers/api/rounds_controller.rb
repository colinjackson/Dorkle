module Api
  class RoundsController < ApplicationController

    def create
      if signed_in?
        @round = current_user.rounds.new(round_params)
      else
        @round = Round.new(round_params)
      end

      if @round.save
        render :show
      else
        render json: { error: @game.errors.full_messages }
      end
    end

    def show
      @round = Round.includes(:game, :answers).find(params[:id])
      render :show
    end

    def update
      @round = Round.includes(:game, :answers).find(params[:id])

      if @round.update(round_params)
        render :show
      else
        render json: { error: @game.errors.full_messages }
      end
    end

    private
    def round_params
      params.require(:round).permit(:game_id, :start_time)
    end

  end
end
