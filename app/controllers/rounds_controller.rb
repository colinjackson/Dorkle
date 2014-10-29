class RoundsController < ApplicationController

  def create
    if signed_in?
      @round = current_user.rounds.new(round_params)
    else
      @round = Round.new(round_params)
    end

    if @round.save
      redirect_to round_url(@round)
    else
      flash.now[:errors] = ["What has science done?!?"] + @round.errors.full_messages
      redirect_to :back
    end
  end

  def show
    @round = Round.includes(:game).find(params[:id])
  end

  def guess
    @round = Round.includes(:game).find(params[:id])
  end

  private
  def round_params
    params.require(:round).permit(:game_id)
  end

end
