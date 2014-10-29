class GameAnswersController < ApplicationController
  before_filter :require_current_user_owner

  def index
    @game = Game.includes(:answers, :author).find(params[:game_id])
    render :index
  end

  def create
    @game = Game.find(params[:game_id])
    game_answer = @game.answers.new(game_answer_params)
    if game_answer.save()
      redirect_to game_answers_url(@game)
    else
      flash.now[:notices] = ["Zounds!"] + game_answer.errors.full_messages
      @game.answers.delete(game_answer)
      render :index
    end
  end

  def destroy
    @game_answer = GameAnswer.find(params[:game_id])
    @game_answer.destroy
    redirect_to game_url(@game_answer.game)
  end

  private
  def game_answer_params
    params.require(:game_answer).permit(:answer)
  end

  def require_current_user_owner
    if !signed_in? || Game.find(params[:game_id]).author_id != current_user.id
      redirect_to games_url
    end
  end

end
