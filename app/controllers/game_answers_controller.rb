class GameAnswersController < ApplicationController
  before_filter :require_current_user_owner

  def index
    @game = Game.includes(:answers).find(params[:id])
    render :index
  end

  def new
    @game = Game.find(params[:id])
    render :new
  end

  def create
    @game_answer = GameAnswer.new(game_answer_params)
    if @game_answer.save()
      redirect_to game_url(@game_answer.game)
    else
      flash.now[:notices] = ["Zounds!"] + @game_answer.errors.full_messages
      render :new
    end
  end

  def destroy
    @game_answer = GameAnswer.find(params[:id])
    @game_answer.destroy
    redirect_to game_url(@game_answer.game)
  end

  private
  def game_answer_params
    params.require(:game_answer).permit(:answer, :game_id)
  end

  def require_current_user_owner
    if !signed_in? || Game.find(params[:id]).author_id != current_user.id
      redirect_to games_url
    end
  end

end
