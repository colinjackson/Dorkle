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
    @game_answer = GameAnswer.find(params[:id])
    @game_answer.destroy
    redirect_to game_answers_url(@game_answer.game)
  end

  private
  def game_answer_params
    params.require(:game_answer).permit(:answer)
  end

  def require_current_user_owner
    invalid = false

    invalid ||= !signed_in?
    if (params[:action] == "destroy")
      invalid ||= GameAnswer.find(params[:id]).game.author_id != current_user.id
    else
      invalid ||= Game.find(params[:game_id]).author_id != current_user.id
    end

    invalid ? redirect_to(games_url) : nil
  end

end
