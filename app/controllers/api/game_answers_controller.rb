module Api
  class GameAnswersController < ApplicationController
    before_filter :require_current_user_owner

    def index
      @game = Game.includes(:answers).find(params[:game_id]);
      render :index
    end

    def create
      @game_answer = GameAnswer.new(game_answer_params);
      if @game_answer.save
        render json: @game_answer;
      else
        render json: { errors: @game_answer.errors.full_messages }
      end
    end

    def update
      @game_answer = GameAnswer.find(params[:id])
      if @game_answer.update(game_answer_params)
        render json: @game_answer
      else
        render json: { errors: @game_answer.errors.full_messages }
      end
    end

    def destroy
      @game_answer = GameAnswer.find(params[:id])
      @game_answer.destroy
      render json: {}
    end

    private
    def game_answer_params
      params.require(:game_answer).permit(:answer, :game_id, :regex)
    end

    def require_current_user_owner
      forbidden = false

      forbidden ||= !signed_in?
      unless forbidden
        if ["update", "destroy"].include?(params[:action])
          game = GameAnswer.find(params[:id]).game
        elsif params[:action] == "index"
          game = Game.find(params[:game_id])
        else
          game = Game.find(game_answer_params[:game_id])
        end

        forbidden = game.author_id != current_user.id
      end

      if forbidden
        render json: { you_are_a: "bad person"}, status: :forbidden
      end
    end

  end
end
