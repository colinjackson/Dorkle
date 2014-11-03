module Api
  class GameAnswersController < ApplicationController
    before_filter :require_current_user_owner

    def index
      @game = Game.includes(:answers).find(params[:game_id]);
      render :index
    end

    # def create
    # end
    #
    # def update
    # end
    #
    # def destroy
    # end

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

      render json: {} if invalid
    end

  end
end
