class RoundsController < ApplicationController

  def create
    if signed_in?
      @round = current_user.rounds.new(round_params)
    else
      @round = Round.new(round_params)
    end

    @round.start_time = Time.now()

    if @round.save
      @round.game.author.notifications.create!(event_id: 1, notifiable: @round)
      redirect_to round_url(@round)
    else
      flash.now[:errors] = ["What has science done?!?"] + @round.errors.full_messages
      redirect_to :back
    end
  end

  def show
    @round = Round.includes(:game, answer_matches: :answer).find(params[:id])
    render :show
  end

  def guess
    @round = Round.includes(:game).find(params[:id])
    @guess = params[:round_guess]
    if @round.handle_guess(@guess)
      flash.now[:successes] = ["#{@guess} is correct!"]
    else
      flash.now[:errors] = ["#{@guess} is incorrect, sorry"]
    end

    render :show
  end

  private
  def round_params
    params.require(:round).permit(:game_id)
  end

end
